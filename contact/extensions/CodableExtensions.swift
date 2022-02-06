//
//  CodableExtensions.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import Foundation
import RxSwift

extension ObservableType where Self.Element == Data? {
	func toDecodable<T: Decodable>() -> RxSwift.Observable<T> {
		return compactMap { (data) -> T? in
			return try data?.toDecodable()
		}
	}
}

extension Data {
	func toDecodable<T: Decodable>() throws -> T {
		return try JSONDecoder().decode(T.self, from: self)
	}
}

extension Encodable {
	func toData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
}

extension Array where Element: Encodable {
	func toData() throws -> Data {
		return try JSONEncoder().encode(self)
	}
}
