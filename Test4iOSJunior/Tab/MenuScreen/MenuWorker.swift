//
//  MenuWorker.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

protocol IMenuWorker {
	func performRequest(for category: String, completion: @escaping (Result<MenuModel.NetworkModel.DrinkResponse, Error>) -> Void) // swiftlint:disable:this line_length
	func convertUrlStringToUIImage(urlString: String, completion: @escaping (UIImage?) -> Void)
}

class MenuWorker: IMenuWorker {

	func performRequest(for category: String, completion: @escaping (Result<MenuModel.NetworkModel.DrinkResponse, Error>) -> Void) { // swiftlint:disable:this line_length
		guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(category)") else { return }
		let urlRequest = URLRequest(url: url)

		let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
			if let error = error {
				completion(.failure(error))
				return
			} else {
				guard let safeData = data else {
					print("Fetching data error")
					return
				}

				do {
					let fetchResult = try JSONDecoder().decode(MenuModel.NetworkModel.DrinkResponse.self, from: safeData)
					completion(.success(fetchResult))
				} catch {
					print("Parsing error: \(error.localizedDescription)")
					completion(.failure(error))
				}
			}
		}

		task.resume()
	}

	func convertUrlStringToUIImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
		guard let imageURL = URL(string: urlString) else {
			completion(nil)
			return
		}

		let task = URLSession.shared.dataTask(with: imageURL) { data, _, error in
			if let error = error {
				print("Error loading image: \(error)")
				completion(nil)
				return
			}

			guard let imageData = data, let image = UIImage(data: imageData) else {
				completion(nil)
				return
			}

			completion(image)
		}

		task.resume()
	}
}
