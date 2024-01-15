//
//  MenuViewController.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

protocol IMenuViewController: AnyObject {
	func render(viewModel: MenuModel.FetchDrinks.ViewModel)
}

class MenuViewController: UIViewController {

	// MARK: - Dependencies

	var interactor: IMenuInteractor?
	private var viewModel: MenuModel.FetchDrinks.ViewModel = MenuModel.FetchDrinks.ViewModel(sectionedDrinks: [])

	// MARK: - Initilization

	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - UI

	private let locationButton: UIButton = {
		let button = UIButton(type: .system)
		button.translatesAutoresizingMaskIntoConstraints = false
		button.contentHorizontalAlignment = .left
		button.semanticContentAttribute = .forceRightToLeft
		button.setTitle("Moscow  ", for: .normal)
		button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
		button.tintColor = .black
		return button
	}()

	private lazy var bannerCollectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = UIColor(named: GlobalUtils.Color.grayBackground)
		collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "bannerCell")
		return collectionView
	}()

	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.delegate = self
		collectionView.dataSource = self
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.backgroundColor = UIColor(named: GlobalUtils.Color.grayBackground)
		collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
		return collectionView
	}()

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero, style: .grouped)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(ItemCellView.self, forCellReuseIdentifier: "itemCell")
		tableView.showsVerticalScrollIndicator = false
		tableView.dataSource = self
		tableView.delegate = self
		return tableView
	}()

	// MARK: - View lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()

		setupConstraints()
		assembly()

		collectionView.delegate = self
		collectionView.dataSource = self
		bannerCollectionView.delegate = self
		bannerCollectionView.dataSource = self

		let repository: IMenuRepository = MenuRepository()
		interactor?.fetchDrinks(requests: repository.getDrinks())
	}

	// MARK: - Assembly of ViewController

	private func assembly() {
		let worker = MenuWorker()
		let presenter = MenuPresenter(viewController: self)
		interactor = MenuInteractor(worker: worker, presenter: presenter)
	}

	// MARK: - Setting up the constraints

	private func setupConstraints() {

		view.backgroundColor = UIColor(named: GlobalUtils.Color.grayBackground)
		view.addSubview(locationButton)
		view.addSubview(bannerCollectionView)
		view.addSubview(collectionView)
		view.addSubview(tableView)

		locationButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Size.Padding.normal).isActive = true // swiftlint:disable:this line_length
		locationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.Padding.normal).isActive = true // swiftlint:disable:this line_length

		bannerCollectionView.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: Size.Padding.normal).isActive = true // swiftlint:disable:this line_length
		bannerCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		bannerCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		bannerCollectionView.heightAnchor.constraint(equalToConstant: Size.L.height).isActive = true

		collectionView.topAnchor.constraint(equalTo: bannerCollectionView.bottomAnchor, constant: Size.Padding.oneAndHalf).isActive = true // swiftlint:disable:this line_length
		collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.Padding.normal).isActive = true // swiftlint:disable:this line_length
		collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		collectionView.heightAnchor.constraint(equalToConstant: Size.S.height).isActive = true

		tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: Size.Padding.oneAndHalf).isActive = true // swiftlint:disable:this line_length
		tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
	}
}

extension MenuViewController: UITableViewDataSource {

	func numberOfSections(in tableView: UITableView) -> Int {
		viewModel.sectionedDrinks.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.sectionedDrinks[section].drinkList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemCellView // swiftlint:disable:this force_cast line_length

		let drinks = viewModel.sectionedDrinks[indexPath.section].drinkList

		cell.itemName.text = drinks[indexPath.row].name
		cell.itemImage.image = drinks[indexPath.row].image

		return cell
	}
}

extension MenuViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 0.0
	}
}

extension MenuViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == bannerCollectionView {
			return 2
		} else {
			return viewModel.sectionedDrinks.count
		}
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == bannerCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath) as! BannerCollectionViewCell // swiftlint:disable:this force_cast line_length
			let repository: IMenuRepository = MenuRepository()
			let images = repository.getBannerImage()
			cell.bannerImage.image = images[indexPath.row]
			return cell
		} else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell // swiftlint:disable:this force_cast line_length
			cell.category.text = viewModel.sectionedDrinks[indexPath.item].category
			return cell
		}
	}
}

extension MenuViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if collectionView == collectionView {
			let section = indexPath.item
			let indexPath = IndexPath(row: 0, section: section)
			self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
		}
	}
}

extension MenuViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize { // swiftlint:disable:this line_length
		if collectionView == bannerCollectionView {
			return CGSize(width: Size.L.width, height: Size.L.height)
		} else {
			let text = viewModel.sectionedDrinks[indexPath.item].category
			let width = text.sizeOf(UIFont.systemFont(ofSize: 17)).width
			return CGSize(width: width + 40.0, height: 30)
		}
	}
}

extension MenuViewController: IMenuViewController {
	func render(viewModel: MenuModel.FetchDrinks.ViewModel) {
		self.viewModel = viewModel

		DispatchQueue.main.async {
			self.collectionView.reloadData()
			self.tableView.reloadData()
		}
	}
}
