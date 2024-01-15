//
//  CategoryCollectionViewCell.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
	lazy var category: UILabel = {
		let label = UILabel()
		label.textColor = UIColor(named: GlobalUtils.Color.pinkText)
		label.font = UIFont.systemFont(ofSize: 17)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.addSubview(category)

		category.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		category.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Size.Padding.normal).isActive = true
		category.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Size.Padding.normal).isActive = true // swiftlint:disable:this line_length
		category.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true

		contentView.layer.cornerRadius = Size.cornerRadius
		contentView.layer.borderWidth = Size.borderWidth
		contentView.layer.borderColor = UIColor(named: GlobalUtils.Color.pinkBackground)?.cgColor
	}

	override var isSelected: Bool {
		didSet {
			contentView.backgroundColor = isSelected ? UIColor(named: GlobalUtils.Color.pinkBackground) : nil
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
