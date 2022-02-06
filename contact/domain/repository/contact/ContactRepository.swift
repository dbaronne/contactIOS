//
//  ContactRepository.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

protocol ContactRepository {
	func getContacts(page: Int, pageSize: Int) -> Observable<[Contact]>
}
