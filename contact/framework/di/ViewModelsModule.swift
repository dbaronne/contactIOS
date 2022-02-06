//
//  ViewModelsModule.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Swinject
import SwinjectAutoregistration

class ViewModelsModule {
	static func configure(container: Container) {
		container.autoregister(ContactDetailViewModel.self, initializer: ContactDetailViewModel.init)
		container.autoregister(ContactListViewModel.self, initializer: ContactListViewModel.init)
	}
}
