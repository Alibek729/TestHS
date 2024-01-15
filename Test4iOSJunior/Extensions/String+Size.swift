//
//  String+Size.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

extension String {

	func sizeOf(_ font: UIFont) -> CGSize {
		return self.size(withAttributes: [NSAttributedString.Key.font: font])
	}
}
