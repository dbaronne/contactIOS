//
//  ContactListViewModel.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift
import RxCocoa

class ContactListViewModel {
	let getContactsUseCase: GetContactUseCase
	let contacts = BehaviorRelay<[Contact]>(value: [])
	var currentPage = 0
	var pageSize = 10
	
	init(getContactsUseCase: GetContactUseCase) {
		self.getContactsUseCase = getContactsUseCase
	}
	
	
	func refreshContacts() -> Observable<Void> {
		currentPage = 0
		return getContacts()
	}
	
	func getContacts() -> Observable<Void> {
		self.currentPage = self.currentPage + 1
		return getContactsUseCase.getContacts(page: currentPage, pageSize: pageSize).map{ result in
			if self.currentPage == 1 {
				self.contacts.accept(result)
			} else {
				self.contacts.accept(self.contacts.value + result)
			}
			return
		}.catch({ error in
			debugPrint("ContactListViewModel.getContacts error=\(error)")
			self.currentPage = self.currentPage - 1
			throw error
		})
	}
	
	func hasMoreContact() -> Bool {
		return currentPage > 0 && (contacts.value.count / currentPage) == pageSize
	}
}
