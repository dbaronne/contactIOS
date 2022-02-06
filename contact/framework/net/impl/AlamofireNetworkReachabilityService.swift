//
//  AlamofireNetworkReachabilityService.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Alamofire
import RxSwift

class AlamofireNetworkReachabilityService: NetworkReachabilityService {
	func checkNetworkReachability() -> Observable<Void> {
		if !NetworkReachabilityManager()!.isReachable {
			debugPrint("Network is not reachable")
			return Observable.error(NetError(withReason: .noNetworkAvailable, withError: nil))
		}
		return Observable.just(())
	}
}
