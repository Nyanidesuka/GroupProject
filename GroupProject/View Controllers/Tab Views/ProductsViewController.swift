//
//  ProductsViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Outlets
    @IBOutlet weak var suggestedProductsCollectionView: UICollectionView!
    @IBOutlet weak var beginnerProductsCollectionView: UICollectionView!
    @IBOutlet weak var intermediateProductsCollectionView: UICollectionView!
    @IBOutlet weak var advancedProductsCollectionView: UICollectionView!
    
    
    
    
    //MARK: - Properties / Local sources of truth
    var suggestedProducts: [Product] = []
    var beginnerProducts: [Product] = ProductController.sharedInstance.products
    var intermediateProducts: [Product] = ProductController.sharedInstance.products
    var advancedProducts: [Product] = ProductController.sharedInstance.products
    


    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
        setupSuggestedProducts()
        setUpAllProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.suggestedProductsCollectionView.reloadData()
        self.beginnerProductsCollectionView.reloadData()
        self.intermediateProductsCollectionView.reloadData()
        self.advancedProductsCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case suggestedProductsCollectionView:
            return suggestedProducts.count
        case beginnerProductsCollectionView:
            return beginnerProducts.count
        case intermediateProductsCollectionView:
            return intermediateProducts.count
        case advancedProductsCollectionView:
            return advancedProducts.count
        default:
            return 0
        }
    }

    
    //MARK: - Actions
    
    
    //Clicking any of the products will send to browser/amazon URL
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {        
        switch collectionView {
        case suggestedProductsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "suggestedProduct", for: indexPath) as? SuggestedProductsCollectionViewCell else {return UICollectionViewCell() }
            cell.suggestedProductNameLabel.text = suggestedProducts[indexPath.row].name
            cell.suggestedProductRatingLabel.text = "Rating: \(suggestedProducts[indexPath.row].rating)"
            cell.suggestedProductsImageView.image = suggestedProducts[indexPath.row].image
            return cell
        case beginnerProductsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "beginnerProducts", for: indexPath) as? BeginnerProductsCollectionViewCell else {return UICollectionViewCell() }
            cell.beginnerProductsNameLabel.text = beginnerProducts[indexPath.row].name
            cell.beginnerProductsRatingLabel.text = "Rating: \(beginnerProducts[indexPath.row].rating)"
            cell.beginnerProductsImageView.image = beginnerProducts[indexPath.row].image
            return cell
        case intermediateProductsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "intermediateProducts", for: indexPath) as? IntermediateProductsCollectionViewCell else {return UICollectionViewCell() }
            cell.intermediateProductsNameLabel.text = intermediateProducts[indexPath.row].name
            cell.intermediateProductsRatingLabel.text = "Rating: \(intermediateProducts[indexPath.row].rating)"
            cell.intermediateProductsImageView.image = intermediateProducts[indexPath.row].image
                return cell
        case advancedProductsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "advancedProducts", for: indexPath) as? AdvancedProductsCollectionViewCell else {return UICollectionViewCell() }
            cell.advancedProductNameLabel.text = advancedProducts[indexPath.row].name
            cell.advancedProductRatingLabel.text = "Rating: \(advancedProducts[indexPath.row].rating)"
            cell.advancedProductsImageView.image = advancedProducts[indexPath.row].image
            return cell
        default:
            return UICollectionViewCell()
            
        }
    }
    //MARK: - Helper functions
    
    func setupCollectionViews() {
        self.suggestedProductsCollectionView.delegate = self
        self.suggestedProductsCollectionView.dataSource = self
        self.beginnerProductsCollectionView.delegate = self
        self.beginnerProductsCollectionView.dataSource = self
        self.intermediateProductsCollectionView.delegate = self
        self.intermediateProductsCollectionView.dataSource = self
        self.advancedProductsCollectionView.delegate = self
        self.advancedProductsCollectionView.dataSource = self
    }
    
    func setupSuggestedProducts() {
        let shuffled = suggestedProducts.shuffled()
        let tags = shuffled.prefix(3)
        suggestedProducts = Array(tags)
    }
    
    func setUpAllProducts(){
         self.suggestedProducts = ProductController.sharedInstance.createFeaturedProducts()
       self.beginnerProducts = ProductController.sharedInstance.grabBeginnerProducts()
       self.intermediateProducts = ProductController.sharedInstance.grabIntermediateProducts()
       self.advancedProducts = ProductController.sharedInstance.grabAdvancedProdcuts()
    }
    
    
    func sendToAmazon(product: Product) {
        guard let url = URL(string: product.url) else { return }
        UIApplication.shared.open(url)
    }

}

