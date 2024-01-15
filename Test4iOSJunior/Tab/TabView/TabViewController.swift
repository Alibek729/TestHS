//
//  TabViewController.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

final class TabViewController: UITabBarController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setupTabBar()
	}

	private func setupTabBar() {
		tabBar.backgroundColor = .white
		tabBar.tintColor = UIColor(named: GlobalUtils.Color.pinkText)
		tabBar.isTranslucent = false

		let menuVC = MenuViewController()
		let contactsVC = ContactsViewController()
		let profileVC = ProfileViewController()
		let basketVC = BasketViewController()

		menuVC.tabBarItem = createTabBarItem(title: "Меню", image: UIImage(named: GlobalUtils.Image.tabMenu), tag: 0)
		contactsVC.tabBarItem = createTabBarItem(title: "Контакты", image: UIImage(named: GlobalUtils.Image.tabContacts), tag: 1) // swiftlint:disable:this line_length
		profileVC.tabBarItem = createTabBarItem(title: "Профиль", image: UIImage(named: GlobalUtils.Image.tabProfile), tag: 2)
		basketVC.tabBarItem = createTabBarItem(title: "Корзина", image: UIImage(named: GlobalUtils.Image.tabBasket), tag: 3)

		viewControllers = [menuVC, contactsVC, profileVC, basketVC]
	}

	private func createTabBarItem(title: String?, image: UIImage?, tag: Int) -> UITabBarItem {
		let tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
		tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: GlobalUtils.Color.pinkText) ?? .systemPink], for: .selected) // swiftlint:disable:this line_length
		return tabBarItem
	}
}
