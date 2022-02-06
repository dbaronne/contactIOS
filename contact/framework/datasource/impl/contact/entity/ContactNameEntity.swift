//
//  ContactNameEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactNameEntity: Codable {
    var title: String?
    var first: String?
    var last: String?
	
	enum CodingKeys: String, CodingKey {
		case title = "title"
		case first = "first"
		case last = "last"
	}
}
