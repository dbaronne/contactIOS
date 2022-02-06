//
//  ContactDetailHeaderView.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import UIKit
import SDWebImage

class ContactDetailHeaderView: UIView {

	var contactImageView = UIImageView()
	var contactNameLabel = UILabel()
	var contactUsernameLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		initNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initNib()
	}

	func initNib() {
		contactNameLabel.textAlignment = .center
		contactNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
		contactNameLabel.textColor = .black
		contactUsernameLabel.textAlignment = .center
		
		let infoView = UIStackView(frame: bounds)
		infoView.addArrangedSubview(contactNameLabel)
		infoView.addArrangedSubview(contactUsernameLabel)
		infoView.distribution = .fill
		infoView.alignment = .fill
		infoView.axis = .vertical
		infoView.spacing = 8
		infoView.clipsToBounds = true
		
		let mainView = UIStackView(frame: bounds)
		mainView.addArrangedSubview(contactImageView)
		mainView.addArrangedSubview(infoView)
		mainView.distribution = .fill
		mainView.alignment = .center
		mainView.axis = .vertical
		mainView.spacing = 24
		mainView.clipsToBounds = true
		
		contactImageView.translatesAutoresizingMaskIntoConstraints = false
		contactNameLabel.translatesAutoresizingMaskIntoConstraints = false
		contactUsernameLabel.translatesAutoresizingMaskIntoConstraints = false
		mainView.translatesAutoresizingMaskIntoConstraints = false
		infoView.translatesAutoresizingMaskIntoConstraints = false

		backgroundColor = .white
		mainView.backgroundColor = .clear
		infoView.backgroundColor = .clear
		
		addSubview(mainView)
		
		NSLayoutConstraint.activate([
			mainView.topAnchor.constraint(equalTo: topAnchor, constant: 32),
			mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
			bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 24),
			trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 24),
			infoView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
			infoView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
			contactImageView.widthAnchor.constraint(equalToConstant: 150),
			contactImageView.heightAnchor.constraint(equalToConstant: 150),
		])
	}
	
	func setInfo(picture: String?, name: String?, username: String?) {
		if let picture = picture {
			contactImageView.sd_setImage(
				with: URL(string: picture),
				placeholderImage: R.image.user(),
				options: .queryMemoryData) { image, _, _, _ in
					if let image = image {
						self.contactImageView.image = image.circle
					}
				}
		} else {
			self.contactImageView.image = R.image.user()?.circle
		}
		contactNameLabel.text = name
		contactNameLabel.isHidden = name == nil
		
		
		
		if let username = username {
			let usernameLabelText = R.string.localizable.usernameLabel()
			let userNameText = "\(usernameLabelText) \(username)"
			let lightAttributes = [
				NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16, weight: .light),
				NSAttributedString.Key.foregroundColor:UIColor.gray
			]
			let regularAttributes = [
				NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .regular),
				NSAttributedString.Key.foregroundColor:UIColor.black
			]
			let attributedSentence = NSMutableAttributedString(string: userNameText, attributes: regularAttributes)
			attributedSentence.setAttributes(lightAttributes, range: NSRange(location: 0, length: usernameLabelText.count))
			contactUsernameLabel.attributedText = attributedSentence
			contactUsernameLabel.isHidden = false
		} else {
			contactUsernameLabel.text = nil
			contactUsernameLabel.isHidden = true
		}
			
	}
}

