//
//  DatabaseContactDataSourceImpl.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import RxSwift

class UserDefaultContactDataSourceImpl: CachedContactDataSource {
	
	let userDefaults: UserDefaults
	let encoder = JSONEncoder()
	let decoder = JSONDecoder()

	init(userDefaults: UserDefaults) {
		self.userDefaults = userDefaults
	}
	
	func getContacts(page: Int, pageSize: Int) -> Observable<[ContactEntity]> {
		do {
			let data = userDefaults.data(forKey: getKey(page: page, pageSize: pageSize))
			let result: [ContactEntity]? = try data?.toDecodable()
			return Observable.just(result ?? [])
		}catch {
			return Observable.error(error)
		}
		
	}
	
	func storeContacts(contacts: [ContactEntity], forPage page: Int, forPageSize pageSize: Int) -> Observable<Void> {
		do {
			let data = try contacts.toData()
			userDefaults.set(data, forKey: getKey(page: page, pageSize: pageSize))
			return Observable.just(())
		}catch {
			return Observable.error(error)
		}
	}
	
	private func getKey(page: Int, pageSize: Int) -> String {
		return "contacts_\(page)_\(pageSize)"
	}
}
