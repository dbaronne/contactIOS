//
//  Contact.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct Contact {
	var uuid: String
	var username: String?
	var gender: String?
	var titleName: String?
	var firstName: String
	var lastName: String
	var location: ContactLocaton?
	var email: String?
	var picture: ContactPicture?
	var phone: String?
	var cell: String?
	var birthdate: Date?
	var age: Int?
}
