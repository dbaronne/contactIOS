//
//  NetworkReachabilityService.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

protocol NetworkReachabilityService {
	func checkNetworkReachability() -> Observable<Void>
}
