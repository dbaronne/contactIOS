//
//  UITableViewCellExtension.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import UIKit

extension UITableViewCell {
	func forceAutoSizing() {
		self.setNeedsLayout()
		self.layoutIfNeeded()
		let height = self.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
		var frame = self.frame
		frame.size.height = height
		self.frame = frame
	}
}
