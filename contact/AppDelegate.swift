//
//  AppDelegate.swift
//  contact
//
//  Created by Damien Baronnet on 05/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		AppConfiguration.configure()
		
		
		let window = UIWindow(frame: UIScreen.main.bounds)
		let navigationViewController = UINavigationController(
			rootViewController: AppConfiguration.container.resolve(ContactListViewController.self)!
		)
		window.rootViewController = navigationViewController
		window.makeKeyAndVisible()
		self.window = window		
		return true
	}


}

