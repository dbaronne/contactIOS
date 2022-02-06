//
//  ContactLocationStreetEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactLocationStreetEntity: Codable {
    var number: String?
    var name: String?
	
	enum CodingKeys: String, CodingKey {
		case number = "number"
		case name = "name"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		name = try container.decode(String?.self, forKey: .name)
		
		do {
			if let value = try container.decode(Int?.self, forKey: .number) {
				number = String(value)
			}
		} catch DecodingError.typeMismatch {
			number = try container.decode(String?.self, forKey: .number)
		}
	}
}
