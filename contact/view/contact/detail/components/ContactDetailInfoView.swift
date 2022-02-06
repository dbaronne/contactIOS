//
//  ContactDetailInfoView.swift
//  contact
//
//  Created by Damien Baronnet on 06/02/2022.
//

import UIKit

class ContactDetailInfoView: UIView {

	var stackView = UIStackView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		initNib()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		initNib()
	}

	func initNib() {
		stackView.distribution = .fill
		stackView.alignment = .fill
		stackView.axis = .vertical
		stackView.spacing = 8
		stackView.clipsToBounds = true
		clipsToBounds = true

		stackView.translatesAutoresizingMaskIntoConstraints = false

		backgroundColor = .white
		stackView.backgroundColor = .clear
		
		addSubview(stackView)
		
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
			stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
			safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
			safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 0)
		])
	}
	
	func setInfos(infos: [(label: String, value: String)]) {
		infos.enumerated().forEach { info in
			let view = ContactDetailLineView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.setInfo(
				label: info.element.label,
				value: info.element.value,
				withSeparator: info.offset < infos.count - 1
			)
			view.clipsToBounds = true
			stackView.addArrangedSubview(view)
		}
	}
}


