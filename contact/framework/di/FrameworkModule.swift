//
//  FrameworkModule.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Swinject
import SwinjectAutoregistration
import Alamofire

class FrameworkModule {
	static func configure(container: Container) {
		configureHttpService(container: container)
		container.register(UserDefaults.self) { r in UserDefaults.standard }
		container.autoregister(RemoteContactDataSource.self, initializer: RemoteContactDataSourceImpl.init)
		container.autoregister(CachedContactDataSource.self, initializer: UserDefaultContactDataSourceImpl.init)
	}
	
	fileprivate static func configureHttpService(container: Container) {
		container.register(HttpService.self) { r in
			AlamofireHttpService(newtorkReachabilityService: r.resolve(NetworkReachabilityService.self)!, sessionManager: Alamofire.Session())
		}
		container.autoregister(NetworkReachabilityService.self, initializer: AlamofireNetworkReachabilityService.init)
	}
}
