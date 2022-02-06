//
//  ContactDetailViewModel.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import RxSwift
import RxCocoa

class ContactDetailViewModel {
	
	var contact: Contact?
	
	var fullName: String? {
		get {
			if let contact = contact {
				return "\(contact.firstName) \(contact.lastName)"
 			}
			return nil
		}
	}
	
	var picture: String? {
		get {
			return contact?.picture?.large
		}
	}
	
	var username: String? {
		get {
			return contact?.username
		}
	}
	
	var cell: String? {
		get {
			return contact?.cell
		}
	}
	
	var phone: String? {
		get {
			return contact?.cell
		}
	}
	
	var location: String? {
		get {
			let locationField = [
				contact?.location?.streetNumber,
				contact?.location?.streetName,
				contact?.location?.postcode,
				contact?.location?.city,
				contact?.location?.state,
				contact?.location?.country,
			]
			return locationField.compactMap{$0}.joined(separator: " ")
		}
	}
	
	var birthdate: String? {
		get {
			return contact?.birthdate?.formatDateString(toFormat: AppConstants.Date.displayFormat)
		}
	}
}
