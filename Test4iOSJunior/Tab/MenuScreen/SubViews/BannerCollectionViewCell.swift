//
//  BannerCollectionViewCell.swift
//  Test4iOSJunior
//
//  Created by Alibek Kozhambekov on 14.01.2024.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {
	let bannerImage: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = Size.cornerRadius
		imageView.clipsToBounds = true
		imageView.contentMode = .scaleAspectFit
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)

		contentView.addSubview(bannerImage)

		bannerImage.heightAnchor.constraint(equalToConstant: Size.L.height).isActive = true
		bannerImage.widthAnchor.constraint(equalToConstant: Size.L.width).isActive = true
		bannerImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
		bannerImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
