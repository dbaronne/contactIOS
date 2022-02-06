//
//  ContactPictureEntity.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

struct ContactPictureEntity: Codable {
    var large: String?
    var medium: String?
    var thumbnail: String?
	
	enum CodingKeys: String, CodingKey {
		case large = "large"
		case medium = "medium"
		case thumbnail = "thumbnail"
	}
}
