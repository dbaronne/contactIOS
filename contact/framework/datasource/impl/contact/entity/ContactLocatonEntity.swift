//
//  ContactLocatonEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactLocatonEntity: Codable {
    var city: String?
    var state: String?
    var country: String?
    var postcode: String?
    var street: ContactLocationStreetEntity?
	
	enum CodingKeys: String, CodingKey {
		case city = "city"
		case state = "state"
		case country = "country"
		case postcode = "postcode"
		case street = "street"
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		city = try container.decode(String?.self, forKey: .city)
		state = try container.decode(String?.self, forKey: .state)
		country = try container.decode(String?.self, forKey: .country)
		street = try container.decode(ContactLocationStreetEntity?.self, forKey: .street)
		
		do {
			if let value = try container.decode(Int?.self, forKey: .postcode) {
				postcode = String(value)
			}
		} catch DecodingError.typeMismatch {
			postcode = try container.decode(String?.self, forKey: .postcode)
		}
	}
}
