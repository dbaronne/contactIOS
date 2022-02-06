//
//  LoadingViewCell.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import Foundation
import UIKit
class LoadingViewCell: UITableViewCell {

	var activityIndicator = UIActivityIndicatorView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initNib()
	}

	func initNib() {
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		
		backgroundColor = .clear
		activityIndicator.color = .blue
		
		contentView.addSubview(activityIndicator)
		
		NSLayoutConstraint.activate([
			activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			contentView.widthAnchor.constraint(equalTo: widthAnchor),
			contentView.heightAnchor.constraint(equalToConstant: 50)
		])
	}
}
