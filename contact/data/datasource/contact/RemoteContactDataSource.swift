//
//  RemoteContactDataSource.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

protocol RemoteContactDataSource {
	func getContacts(page: Int, pageSize: Int) -> Observable<[ContactEntity]>
}
