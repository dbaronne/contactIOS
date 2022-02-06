//
//  DateExtensions.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import Foundation

extension Date {
	func formatDateString(toFormat: String) -> String? {
		let dateToStringFormatter = DateFormatter()
		dateToStringFormatter.dateFormat = toFormat
		let stringDate = dateToStringFormatter.string(from: self)
		return stringDate
	}
}
