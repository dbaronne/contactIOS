//
//  ContactBirthdateEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactBirthdateEntity: Codable {
    var date: String?
    var age: Int?
	
	enum CodingKeys: String, CodingKey {
		case date = "date"
		case age = "age"
	}
}
