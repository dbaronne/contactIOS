//
//  ContactRepositoryImpl.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift

class ContactRepositoryImpl: ContactRepository {
	
	let remoteContactDataSource: RemoteContactDataSource
	let dataBaseContactDataSource: CachedContactDataSource
	
	init(remoteContactDataSource: RemoteContactDataSource, dataBaseContactDataSource: CachedContactDataSource) {
		self.remoteContactDataSource = remoteContactDataSource
		self.dataBaseContactDataSource = dataBaseContactDataSource
	}
	
	func getContacts(page: Int, pageSize: Int) -> Observable<[Contact]> {
		return remoteContactDataSource.getContacts(page: page, pageSize: pageSize)
			.flatMap{ contacts in
				self.dataBaseContactDataSource.storeContacts(contacts: contacts, forPage: page, forPageSize: pageSize)
					.map { contacts }
			}
			.catch { error in
				guard let error = error as? NetError, error.reason == .noNetworkAvailable else {
					throw error
				}
				return self.dataBaseContactDataSource.getContacts(page: page, pageSize: pageSize)
			}.map { entity in entity.compactMap { contact in contact.toModel()} }
	}
}

private extension ContactEntity {
	func toModel() -> Contact? {
		if let uuidValue = self.login?.uuid, let firstNameValue = self.name?.first, let lastNameValue = self.name?.last {
		return Contact(
			uuid : uuidValue,
			username : self.login?.username,
			gender : self.gender,
			titleName : self.name?.title,
			firstName : firstNameValue,
			lastName : lastNameValue,
			location : ContactLocaton(
				city : self.location?.city,
				state : self.location?.state,
				country : self.location?.country,
				postcode : self.location?.postcode,
				streetNumber : self.location?.street?.number,
				streetName : self.location?.street?.name
			), email : self.email,
			picture : ContactPicture(
				large : self.picture?.large,
				medium : self.picture?.medium,
				thumbnail : self.picture?.thumbnail
			), phone : self.phone,
			cell : self.cell,
			birthdate : self.birthdate?.date?.toDate(fromFormat: AppConstants.Date.apiFormat),
			age : self.birthdate?.age
		)
		}
		return nil
	}
}

