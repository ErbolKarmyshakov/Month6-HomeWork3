//
//  ViewController.swift
//  Month6-HomeWork3
//
//  Created by Mac User on 10/1/24.
//

import UIKit

class ProductsViewController: UIViewController,
                              UICollectionViewDelegateFlowLayout,                              UICollectionViewDataSource {
    
    private var productStruct: [Product] = []
    
    private let networkLayer = NetworkLayer()
    
    private let collectioView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 250, height: 250)
        layout.minimumLineSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .brown
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allSetUpConstraints()
        view.backgroundColor = .systemBrown
        fetchProduct()
        print(productStruct)
    }
    
    private func allSetUpConstraints() {
        setUpConstraintsForCollectionView()
    }
    
    private func setUpConstraintsForCollectionView() {
        view.addSubview(collectioView)
        NSLayoutConstraint.activate([
            collectioView.topAnchor.constraint(equalTo: view.topAnchor),
            collectioView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectioView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectioView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectioView.delegate = self
        collectioView.dataSource = self
        collectioView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: ProductsCollectionViewCell.reuseID)
    }
    
    private func fetchProduct() {
        networkLayer.fetchProducts { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let model):
                self.productStruct = model
                DispatchQueue.main.async {
                    self.collectioView.reloadData()
                }
                print(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func updateProduct(_ product: Product) {
        networkLayer.updateProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model )
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func addProduct(_ product: Products) {
        networkLayer.addNewProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model )
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func deleteProduct(_ product: Product) {
        networkLayer.deleteProduct(with: product) { result in
            switch result {
            case .success(let model):
                print(model )
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productStruct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.reuseID, for: indexPath) as! ProductsCollectionViewCell
        let pr = productStruct[indexPath.item]
        cell.setUp(with: pr)
        cell.backgroundColor = .systemCyan
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height:200)
    }
}

