//
//  ContactLoginEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactLoginEntity: Codable {
    var username: String?
    var uuid: String?
	
	enum CodingKeys: String, CodingKey {
		case username = "username"
		case uuid = "uuid"
	}
}
