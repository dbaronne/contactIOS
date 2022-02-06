//
//  AlamofireHttpService.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Alamofire
import RxSwift

class AlamofireHttpService: HttpService {
	var newtorkReachabilityService: NetworkReachabilityService
	var sessionManager: Session
	var disposeBag = DisposeBag()

	init(newtorkReachabilityService: NetworkReachabilityService, sessionManager: Session) {
		self.newtorkReachabilityService = newtorkReachabilityService
		self.sessionManager = sessionManager
	}
	
	func get<T>(url: String, headers: [String: String]?) -> Observable<T?> where T:Decodable {
		return doRequest(.get, url, nil, headers).toDecodable()
	}
	
	func post<T>(url: String, parameters: Data?) -> Observable<T?> where T:Decodable {
		return doRequest(.post, url, parameters, nil).toDecodable()
	}
	
	func doRequest(_ httpMethod: HTTPMethod, _ endPoint: String, _ parameters: Data?,
				   _ headers: [String: String]?) -> Observable<Data?> {
		return newtorkReachabilityService.checkNetworkReachability()
			.map { try self.createRequest(endPoint, httpMethod, parameters, headers) }
			.map { try self.encodeRequest(request: $0) }
			.flatMap { self.rxRequest(request: $0) }
			.map { try self.parseResponse(response: $0) }
	}
	
	func createRequest(_ endPoint: String, _ httpMethod: HTTPMethod, _ body: Data? = nil,
					   _ headers: [String: String]? = nil) throws -> URLRequest {
		guard let url = URL(string: endPoint) else {
			throw NetError(withReason: .other, withError: nil)
		}
		
		var request = URLRequest(url: url)
		request.httpMethod = httpMethod.rawValue
		request.httpBody = body
		request.allHTTPHeaderFields = ApiConstants.defaultHeaders.merging(headers ?? [:]) { $1 }
		debugPrint(request)
		return request
	}
	
	func encodeRequest(request: URLRequest) throws -> URLRequest {
		guard let encodedRequest = try? JSONEncoding.default.encode(request) else {
			throw NetError(withReason: .other, withError: nil)
		}
		return encodedRequest
	}
	
	func rxRequest(request: URLRequest) -> Observable<AFDataResponse<Data?>> {
		return Observable.create { (observer) -> Disposable in
			self.sessionManager.request(request).validate().response { response in
				observer.onNext(response)
			}
			return Disposables.create {}
		}
	}
	
	func parseResponse(response: AFDataResponse<Data?>) throws -> Data? {
		switch response.result {
			case .success:
				return try? response.result.get()
			case let .failure(error):
				debugPrint(error)
				throw NetError(
					withReason: response.response?.statusCode == 401 ? .unauthorized : .other,
					withError: error
				)
		}
	}
}
