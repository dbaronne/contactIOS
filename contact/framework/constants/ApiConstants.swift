//
//  ApiConstants.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

enum ApiConstants {
	private static let baseUrl = "https://randomuser.me/"
	static let defaultHeaders: [String: String] = [
		"Accept": "application/json",
		"Content-Type": "application/json; charset=utf-8"
	]
	enum Contact {
		static let get = "\(baseUrl)api/?seed=abc&page=%@&results=%@"
	}
}
