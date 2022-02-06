//
//  ContactEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactEntity: Codable {
	var gender: String?
	var name: ContactNameEntity?
	var location: ContactLocatonEntity?
	var email: String?
	var picture: ContactPictureEntity?
	var phone: String?
	var cell: String?
	var birthdate: ContactBirthdateEntity?
	var login: ContactLoginEntity?
	
	enum CodingKeys: String, CodingKey {
		case gender = "gender"
		case name = "name"
		case location = "location"
		case email = "email"
		case picture = "picture"
		case phone = "phone"
		case cell = "cell"
		case birthdate = "dob"
		case login = "login"
	}
}
