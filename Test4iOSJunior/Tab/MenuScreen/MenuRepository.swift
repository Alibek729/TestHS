//
//  MenuRepository.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

protocol IMenuRepository {
	func getDrinks() -> [MenuModel.FetchDrinks.Request]
	func getBannerImage() -> [UIImage]
}

class MenuRepository: IMenuRepository {
	func getDrinks() -> [MenuModel.FetchDrinks.Request] {
		[
			MenuModel.FetchDrinks.Request(category: "Shake"),
			MenuModel.FetchDrinks.Request(category: "Cocktail"),
			MenuModel.FetchDrinks.Request(category: "Beer"),
			MenuModel.FetchDrinks.Request(category: "Ordinary_Drink")
		]
	}

	func getBannerImage() -> [UIImage] {
		[
			UIImage(named: GlobalUtils.Image.bannerImageOne)!, // swiftlint:disable:this force_unwrapping
			UIImage(named: GlobalUtils.Image.bannerImageTwo)! // swiftlint:disable:this force_unwrapping
		]
	}
}
