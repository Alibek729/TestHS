//
//  ItemCellView.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

class ItemCellView: UITableViewCell {

	let itemImage: UIImageView = {
		let imageFrame = CGRect(x: 0, y: 0, width: Size.XL.height, height: Size.XL.height)
		let imageView = UIImageView(frame: imageFrame)
		imageView.layer.cornerRadius = Size.cornerRadius
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()

	let itemName: UILabel = {
		let label = UILabel()
		label.textColor = .black
		label.numberOfLines = 0
		label.font = UIFont.systemFont(ofSize: 17)
		label.textAlignment = .left
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	lazy var hStack: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fill
		stackView.spacing = Size.Padding.double
		stackView.translatesAutoresizingMaskIntoConstraints = false

		stackView.addArrangedSubview(itemImage)
		stackView.addArrangedSubview(itemName)
		stackView.alignment = .leading
		return stackView
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setupConstraints() {
		contentView.addSubview(hStack)

		itemImage.heightAnchor.constraint(equalToConstant: Size.XL.height).isActive = true
		itemImage.widthAnchor.constraint(equalToConstant: Size.XL.height).isActive = true
		itemImage.centerYAnchor.constraint(equalTo: hStack.centerYAnchor).isActive = true

		itemName.topAnchor.constraint(equalTo: hStack.topAnchor, constant: Size.Padding.normal).isActive = true
		itemName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Size.Padding.oneAndHalf).isActive = true // swiftlint:disable:this line_length

		hStack.heightAnchor.constraint(equalToConstant: Size.XXL.height).isActive = true
		hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Size.Padding.normal).isActive = true
		hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Size.Padding.oneAndHalf).isActive = true // swiftlint:disable:this line_length
		hStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.Padding.half).isActive = true
		hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Size.Padding.half).isActive = true
		hStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}
}
