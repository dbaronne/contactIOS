//
//  DataModule.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Swinject

class DataModule {
	
	static func configure(container: Container) {
		container.autoregister(ContactRepository.self, initializer: ContactRepositoryImpl.init)
	}
}
