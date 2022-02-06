//
//  AppConfiguration.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Swinject

class AppConfiguration {
	static var container = Container()

	static func configure() {
		FrameworkModule.configure(container: container)
		DataModule.configure(container: container)
		DomainModule.configure(container: container)
		ViewModelsModule.configure(container: container)
		ViewControllerModule.configure(container: container)
	}
}
