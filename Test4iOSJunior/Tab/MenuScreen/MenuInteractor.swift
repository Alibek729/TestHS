//
//  MenuInteractor.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import Foundation

protocol IMenuInteractor {
	func fetchDrinks(requests: [MenuModel.FetchDrinks.Request])
}

class MenuInteractor: IMenuInteractor {
	var worker: IMenuWorker
	var presenter: IMenuPresenter?

	init(worker: IMenuWorker, presenter: IMenuPresenter) {
		self.worker = worker
		self.presenter = presenter
	}

	func fetchDrinks(requests: [MenuModel.FetchDrinks.Request]) {
		var responses: [MenuModel.FetchDrinks.Response] = []

		let serialQueue = DispatchQueue(label: "com.example.menuInteractor.serialQueue")

		serialQueue.async { // swiftlint:disable:this closure_body_length
			for request in requests {
				let semaphore = DispatchSemaphore(value: 0)
				self.worker.performRequest(for: request.category) { result in
					switch result {
					case .success(let response):
						var drinksWithImages: [MenuModel.NetworkModel.Drink] = []
						let group = DispatchGroup()
						for drink in response.drinks {
							group.enter()
							self.worker.convertUrlStringToUIImage(urlString: drink.strDrinkThumb) { image in
								var drinkWithImage = drink
								drinkWithImage.drinkImage = image
								drinksWithImages.append(drinkWithImage)
								group.leave()
							}
						}
						group.notify(queue: .main) {
							let drinkResponse = MenuModel.FetchDrinks.Response(category: request.category, drinks: drinksWithImages)
							responses.append(drinkResponse)
							semaphore.signal()
						}
					case .failure(let error):
						print(error.localizedDescription)
						semaphore.signal()
					}
				}
				semaphore.wait()
			}

			DispatchQueue.main.async {
				self.presenter?.presentFetchedDrinks(responses: responses)
			}
		}
	}
}
