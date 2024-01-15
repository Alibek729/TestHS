//
//  MenuPresenter.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

protocol IMenuPresenter {
	func presentFetchedDrinks(responses: [MenuModel.FetchDrinks.Response])
}

class MenuPresenter: IMenuPresenter {
	weak var viewController: IMenuViewController?

	init(viewController: IMenuViewController?) {
		self.viewController = viewController
	}

	// MARK: - Present fetched drinks

	func presentFetchedDrinks(responses: [MenuModel.FetchDrinks.Response]) {

		var sectionWithDrinks = [MenuModel.FetchDrinks.ViewModel.Section]()

		for response in responses {
			let section = MenuModel.FetchDrinks.ViewModel.Section(
				category: response.category,
				drinkList: response.drinks.map { drink in
					return MenuModel.FetchDrinks.ViewModel.Drink(
						name: drink.strDrink,
						image: drink.drinkImage ?? UIImage(systemName: "xmark")! // swiftlint:disable:this force_unwrapping
					)
				}
			)

			sectionWithDrinks.append(section)
		}

		let viewModel = MenuModel.FetchDrinks.ViewModel(sectionedDrinks: sectionWithDrinks)

		DispatchQueue.main.async { [weak self] in
			self?.viewController?.render(viewModel: viewModel)
		}
	}
}
