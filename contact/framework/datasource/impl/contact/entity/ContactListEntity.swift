//
//  ContactListEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactListEntity: Codable {
    var data: [ContactEntity]?
	
	enum CodingKeys: String, CodingKey {
		case data = "results"
	}
}
