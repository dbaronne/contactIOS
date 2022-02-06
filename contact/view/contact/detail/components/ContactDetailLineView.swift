//
//  ContactDetailLineView.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import UIKit

class ContactDetailLineView: UIView {

	var labelView = UILabel()
	var valueLabel = UILabel()
	var separatorView = UIView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		initNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initNib()
	}

	func initNib() {
		labelView.textAlignment = .left
		labelView.font = UIFont.systemFont(ofSize: 16, weight: .light)
		labelView.textColor = .gray
		valueLabel.textAlignment = .left
		valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
		valueLabel.numberOfLines = 0
		valueLabel.textColor = .black
		
		let infoView = UIStackView(frame: bounds)
		infoView.addArrangedSubview(labelView)
		infoView.addArrangedSubview(valueLabel)
		infoView.distribution = .fill
		infoView.alignment = .fill
		infoView.axis = .vertical
		infoView.spacing = 4
		
		let mainView = UIStackView(frame: bounds)
		mainView.addArrangedSubview(infoView)
		mainView.addArrangedSubview(separatorView)
		mainView.distribution = .fill
		mainView.alignment = .fill
		mainView.axis = .vertical
		mainView.spacing = 8
		
		labelView.translatesAutoresizingMaskIntoConstraints = false
		valueLabel.translatesAutoresizingMaskIntoConstraints = false
		mainView.translatesAutoresizingMaskIntoConstraints = false
		infoView.translatesAutoresizingMaskIntoConstraints = false

		backgroundColor = .white
		mainView.backgroundColor = .clear
		infoView.backgroundColor = .clear
		separatorView.backgroundColor = R.color.detailBackgroundColor()
		
		addSubview(mainView)
		
		NSLayoutConstraint.activate([
			mainView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
			mainView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 24),
			safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0),
			safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: 24),
		])
	}
	
	func setInfo(label: String, value: String, withSeparator: Bool = true) {
		labelView.text = label
		valueLabel.text = value
		separatorView.isHidden = !withSeparator
	}
}


