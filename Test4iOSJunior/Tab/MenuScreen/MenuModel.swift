//
//  MenuModel.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

enum MenuModel {

	struct FetchDrinks { // swiftlint:disable:this convenience_type

		struct Request {
			let category: String
		}

		struct Response {
			let category: String
			let drinks: [NetworkModel.Drink]
		}

		struct ViewModel {

			struct Drink {
				let name: String
				let image: UIImage
			}

			struct Section {
				let category: String
				let drinkList: [Drink]
			}

			let sectionedDrinks: [Section]
		}
	}

	enum NetworkModel {
		struct DrinkResponse: Decodable {
			let drinks: [Drink]
		}

		struct Drink: Decodable {
			let idDrink: String
			let strDrink: String
			let strDrinkThumb: String
			var drinkImage: UIImage?

			enum CodingKeys: String, CodingKey {
				case idDrink
				case strDrink
				case strDrinkThumb
			}

			init(from decoder: Decoder) throws {
				let container = try decoder.container(keyedBy: CodingKeys.self)
				idDrink = try container.decode(String.self, forKey: .idDrink)
				strDrink = try container.decode(String.self, forKey: .strDrink)
				strDrinkThumb = try container.decode(String.self, forKey: .strDrinkThumb)
				drinkImage = nil
			}
		}
	}
}
