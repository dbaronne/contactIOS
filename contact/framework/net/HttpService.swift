//
//  HttpService.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

protocol HttpService {
	
	func get<T>(url: String, headers: [String: String]?) -> Observable<T?> where T:Decodable
	
	func post<T>(url: String, parameters: Data?) -> Observable<T?> where T:Decodable
}
