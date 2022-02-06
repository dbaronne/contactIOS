//
//  StringExtensions.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

extension String {
	func toDate(fromFormat: String) -> Date?
	{
		let stringToDateFormatter = DateFormatter()
		stringToDateFormatter.dateFormat = fromFormat
		return stringToDateFormatter.date(from: self)
	}
}
