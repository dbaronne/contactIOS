//
//  ResultViewCell.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import UIKit
import SDWebImage

class ContactViewCell: UITableViewCell {

	var contactImageView = UIImageView()
	var contactNameLabel = UILabel()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		initNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initNib()
	}

	func initNib() {
		let stackView = UIStackView(frame: bounds)
		stackView.addArrangedSubview(contactImageView)
		stackView.addArrangedSubview(contactNameLabel)
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.axis = .horizontal
		stackView.spacing = 16
		
		contactImageView.translatesAutoresizingMaskIntoConstraints = false
		contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false

		backgroundColor = .clear
		contentView.backgroundColor = .clear
		stackView.backgroundColor = .clear
		
		contentView.addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
			contentView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
			contentView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 24),
			contactImageView.widthAnchor.constraint(equalToConstant: 40),
			contactImageView.heightAnchor.constraint(equalToConstant: 40),
		])
	}
	
	func setContact(contact: Contact) {
		if let thumbnail = contact.picture?.thumbnail {
			contactImageView.sd_setImage(with: URL(string: thumbnail), placeholderImage: R.image.user(), options: .queryMemoryData) { image, _, _, _ in
				if let image = image {
					self.contactImageView.image = image.circle
				}
			}
		} else {
			self.contactImageView.image = R.image.user()?.circle
		}
		contactNameLabel.text = "\(contact.firstName) \(contact.lastName)"
	}
}
