//
//  ContactDetailViewController.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ContactDetailViewController: UIViewController {

	var viewModel: ContactDetailViewModel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = R.string.localizable.contactDetailTitle()
		initView()
	}

	// MARK: init view
	
	fileprivate func initView() {
		self.view.backgroundColor = R.color.detailBackgroundColor()
		let scrollView = UIScrollView(frame: self.view.frame)
		let contentScrollView = UIView()
		scrollView.addSubview(contentScrollView)
		
		let headerView = ContactDetailHeaderView()
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.setInfo(
			picture: self.viewModel.picture,
			name: self.viewModel.fullName,
			username: self.viewModel.username
		)
		
		let infoView = ContactDetailInfoView()
		infoView.setInfos(infos: getInfos())
		
		let mainView = UIStackView(frame: self.view.bounds)
		mainView.addArrangedSubview(headerView)
		mainView.addArrangedSubview(infoView)
		mainView.distribution = .fill
		mainView.alignment = .fill
		mainView.axis = .vertical
		mainView.spacing = 24
		
		mainView.backgroundColor = .clear
		infoView.backgroundColor = .white
		
		infoView.layer.cornerRadius = 32
		headerView.layer.cornerRadius = 32
		headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		contentScrollView.translatesAutoresizingMaskIntoConstraints = false
		mainView.translatesAutoresizingMaskIntoConstraints = false
		infoView.translatesAutoresizingMaskIntoConstraints = false
		
		self.view.addSubview(scrollView)
		contentScrollView.addSubview(mainView)
		
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			
			contentScrollView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			contentScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
			contentScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
			contentScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			contentScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
			
			mainView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
			mainView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
			mainView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
			mainView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor)
		])
	}
	
	// MARK: data management
	
	private func getInfos() -> [(label: String, value: String)] {
		return [
			(label: R.string.localizable.cellLabel(), value: self.viewModel.cell),
			(label: R.string.localizable.phoneLabel(), value: self.viewModel.phone),
			(label: R.string.localizable.locationLabel(), value: self.viewModel.location),
			(label: R.string.localizable.birthdateLabel(), value: self.viewModel.birthdate),
		].compactMap{
			if let value = $0.value {
				return (label: $0.label, value: value)
			} else {
				return nil
			}
		}
	}
	
}

