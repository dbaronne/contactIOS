//
//  DatabaseContactDataSource.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import RxSwift

protocol CachedContactDataSource {
	func getContacts(page: Int, pageSize: Int) -> Observable<[ContactEntity]>
	func storeContacts(contacts: [ContactEntity], forPage page: Int, forPageSize pageSize: Int) -> Observable<Void>
}
