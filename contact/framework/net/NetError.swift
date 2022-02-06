//
//  NetError.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

class NetError: Error {
	let reason: NetErrorReason
	let error: Error?

	init(withReason reason: NetErrorReason, withError error: Error?) {
		self.reason = reason
		self.error = error
	}
}

enum NetErrorReason {
	case unauthorized
	case noNetworkAvailable
	case other
	case conversionError
	case tokenNotFound
}
