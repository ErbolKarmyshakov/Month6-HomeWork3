//
//  ProductsCollectionViewCell.swift
//  Month6-HomeWork3
//
//  Created by Mac User on 10/1/24.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "productsCell"
    
    private let productImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productTitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let productDescription: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        allSetUpConstraints()
    }
    
    private func allSetUpConstraints() {
        setUpConstraintsForProductImageView()
        setUpConstraintsForProductTitle()
        setUpConstraintsForProductDescription()
    }
    
    private func setUpConstraintsForProductImageView() {
        contentView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            productImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 80),
            productImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setUpConstraintsForProductTitle() {
        contentView.addSubview(productTitle)
        NSLayoutConstraint.activate([
            productTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            productTitle.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10)
        ])
    }
    
    private func setUpConstraintsForProductDescription() {
        contentView.addSubview(productDescription)
        NSLayoutConstraint.activate([
            productDescription.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 15),
            productDescription.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 10)
        ])
    }
    
    func setUp(with product: Product) {
        productImageView.image = UIImage(named: product.images)
        productTitle.text = product.title
        productDescription.text = product.description
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
