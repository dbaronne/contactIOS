//
//  GetContactUseCaseImpl.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

class GetContactUseCaseImpl: GetContactUseCase {
	
	let contactRepository: ContactRepository
	
	init(contactRepository: ContactRepository) {
		self.contactRepository = contactRepository
	}
	
	func getContacts(page: Int, pageSize: Int) -> Observable<[Contact]> {
		return contactRepository.getContacts(page: page, pageSize: pageSize)
	}
}
