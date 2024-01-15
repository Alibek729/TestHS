//
//  Size.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import Foundation

// swiftlint:disable type_name
enum Size {

	static let cornerRadius: CGFloat = 8
	static let borderWidth: CGFloat = 1

	enum Padding {
		static let half: CGFloat = 8
		static let normal: CGFloat = 16
		static let oneAndHalf: CGFloat = 24
		static let double: CGFloat = 32
	}

	enum XXL {
		static let width: CGFloat = 400
		static let height: CGFloat = 156
	}

	enum XL {
		static let width: CGFloat = 350
		static let height: CGFloat = 132
	}

	enum L {
		static let width: CGFloat = 300
		static let height: CGFloat = 112
		static let widthMultiplier: CGFloat = 0.9
	}

	enum M {
		static let width: CGFloat = 200
		static let height: CGFloat = 74
	}

	enum S {
		static let width: CGFloat = 80
		static let height: CGFloat = 32
	}
}
// swiftlint:enable type_name
