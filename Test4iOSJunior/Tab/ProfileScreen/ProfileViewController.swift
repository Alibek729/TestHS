//
//  ProfileViewController.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 15.01.2024.
//

import UIKit

class ProfileViewController: UIViewController {

	// MARK: - Initilization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .yellow
		// Do any additional setup after loading the view.
	}
}
