//
//  ViewExtensions.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import UIKit

extension UIView {
	
	func roundAndAddShadow(radius: CGFloat) {
		layer.shadowColor = UIColor.lightGray.cgColor
		layer.shadowOpacity = 0.6
		layer.shadowOffset = .zero
		layer.shadowRadius = 4
		layer.cornerRadius = radius
	}
}
