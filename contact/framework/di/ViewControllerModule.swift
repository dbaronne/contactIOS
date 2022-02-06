//
//  ViewControllerModule.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Swinject

class ViewControllerModule {
	static func configure(container: Container) {
		container.register(ContactListViewController.self) { r in
			let controller = ContactListViewController()
			controller.viewModel = r.resolve(ContactListViewModel.self)
			return controller
		}
		
		container.register(ContactDetailViewController.self) { r in
			let controller = ContactDetailViewController()
			controller.viewModel = r.resolve(ContactDetailViewModel.self)
			return controller
		}
	}
}
