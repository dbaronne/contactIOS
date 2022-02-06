//
//  DomainModule.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

import Swinject
import SwinjectAutoregistration

class DomainModule {
	
	static func configure(container: Container) {
		container.autoregister(GetContactUseCase.self, initializer: GetContactUseCaseImpl.init)
	}
}
