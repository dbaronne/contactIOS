//
//  ContactListViewController.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ContactListViewController: UITableViewController {

	var viewModel: ContactListViewModel!
	var hasDataLoaded = false
	let disposeBag = DisposeBag()
	let cellReuseIdentifier = "contactViewCell"
	let loadingReuseIdentifier = "loadingViewCell"
	var activityIndicatorContent = UIView()
	var activityIndicator = UIActivityIndicatorView()
	var isLoadingMore = BehaviorRelay(value: false)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		title = R.string.localizable.contactListTitle()
		initActivityIndicatorView()
		initTableView()

		viewModel.contacts.observe(on: MainScheduler.instance).subscribe(onNext: { _ in
			self.tableView.reloadData()
		}).disposed(by: disposeBag)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		if !hasDataLoaded {
			hasDataLoaded = true
			getContacts(needShowLoader: true)
		}
	}
	
	// MARK: - Data Management methods
	
	private func getContacts(needShowLoader: Bool) {
		showLoader(isLoading: true, needShowLoader: needShowLoader)
		Observable.just(())
			.observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
			.flatMap{ self.viewModel.getContacts() }
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: {
				self.showLoader(isLoading: false, needShowLoader: needShowLoader)
				self.isLoadingMore.accept(false)
			},onError: { error in
				self.showLoader(isLoading: false, needShowLoader: needShowLoader)
				self.isLoadingMore.accept(false)
				let alert = UIAlertController(title: nil, message: R.string.localizable.searchError(), preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: R.string.localizable.cancel(), style: .default, handler: { action in
					self.navigationController?.popViewController(animated: true)
				}))
				alert.addAction(UIAlertAction(title: R.string.localizable.retry(), style: .default, handler: { action in
					self.getContacts(needShowLoader: needShowLoader)
				}))
				self.present(alert, animated: true, completion: nil)
			})
			.disposed(by: disposeBag)
	}
	
	@objc private func refreshWeatherData(_ sender: Any) {
		Observable.just(())
			.observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
			.flatMap{ self.viewModel.refreshContacts() }
			.observe(on: MainScheduler.instance)
			.subscribe(onNext: {
				self.refreshControl?.endRefreshing()
			}, onError: { _ in
				self.refreshControl?.endRefreshing()
			})
			.disposed(by: disposeBag)
	}
	
	// MARK: - Loaders methods
	
	fileprivate func initActivityIndicatorView() {
		activityIndicator.color = .blue
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false
		activityIndicatorContent.translatesAutoresizingMaskIntoConstraints = false
		//self.view.translatesAutoresizingMaskIntoConstraints = false
		activityIndicatorContent.backgroundColor = .darkGray.withAlphaComponent(0.5)
		activityIndicatorContent.addSubview(activityIndicator)
		self.view.addSubview(activityIndicatorContent)
		
		NSLayoutConstraint.activate([
			activityIndicatorContent.topAnchor.constraint(equalTo: self.view.topAnchor),
			activityIndicatorContent.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			activityIndicatorContent.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			activityIndicatorContent.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
			activityIndicatorContent.widthAnchor.constraint(equalTo: self.view.widthAnchor),
			activityIndicatorContent.heightAnchor.constraint(equalTo: self.view.heightAnchor),
			activityIndicator.centerYAnchor.constraint(equalTo: activityIndicatorContent.centerYAnchor),
			activityIndicator.centerXAnchor.constraint(equalTo: activityIndicatorContent.centerXAnchor),
		])
	}
	
	private func showLoader(isLoading: Bool, needShowLoader: Bool) {
		if needShowLoader {
			if isLoading {
				activityIndicator.startAnimating()
				activityIndicatorContent.isHidden = false
			} else {
				activityIndicator.stopAnimating()
				activityIndicatorContent.isHidden = true
			}
		}
	}
	
	// MARK: - tableview delegate methods
	
	fileprivate func initTableView() {
		// You must register the cell with a reuse identifier
		tableView.register(ContactViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
		tableView.register(LoadingViewCell.self, forCellReuseIdentifier: loadingReuseIdentifier)
		refreshControl = UIRefreshControl()
		refreshControl?.tintColor = .blue
		refreshControl?.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
		
		tableView.delegate = self
		tableView.dataSource = self
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.hasMoreContact() ? 2 : 1
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return viewModel.contacts.value.count
		} else if section == 1 {
			return 1
		} else {
			return 0
		}
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
			if let cell = cell as? ContactViewCell {
				cell.setContact(contact: self.viewModel.contacts.value[indexPath.row])
				cell.forceAutoSizing()
			}
			return cell
		} else {
			let cell = tableView.dequeueReusableCell(withIdentifier: loadingReuseIdentifier, for: indexPath)
			if let cell = cell as? LoadingViewCell {
				cell.activityIndicator.startAnimating()
				isLoadingMore.map{ !$0 }.bind(to: cell.rx.isHidden).disposed(by: disposeBag)
				cell.forceAutoSizing()
			}
			return cell
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if indexPath.section == 0 {
			let contact = self.viewModel.contacts.value[indexPath.row]
			if let detailVc = AppConfiguration.container.resolve(ContactDetailViewController.self) {
				detailVc.viewModel.contact = contact
				self.navigationController?.pushViewController(detailVc, animated: true)
			}
		}
	}
	
	override func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height

		if (offsetY > contentHeight - scrollView.frame.height) && !isLoadingMore.value && viewModel.hasMoreContact() {
			isLoadingMore.accept(true)
			getContacts(needShowLoader: false)
		}
	}
	
}
