//
//  RemoteContactDataSourceImpl.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

class RemoteContactDataSourceImpl: RemoteContactDataSource {
	
	let httpService: HttpService
	
	init(httpService: HttpService) {
		self.httpService = httpService
	}
	
	func getContacts(page: Int, pageSize: Int) -> Observable<[ContactEntity]> {
		let url = String(format: ApiConstants.Contact.get, String(page), String(pageSize))
		let result: Observable<ContactListEntity?> = httpService.get(url: url, headers: nil)
		return result.map { entity in entity?.data ?? [] }
	}
}
