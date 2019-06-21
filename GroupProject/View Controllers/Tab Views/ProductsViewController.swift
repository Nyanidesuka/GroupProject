//
//  ProductsViewController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    //MARK: - Outlets
    
    //MARK: - Properties / Local sources of truth
    


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    //Clicking any of the products will send to browser/amazon URL

    
    //MARK: - Helper functions
    func sendToAmazon(product: Product) {
        guard let url = URL(string: product.url) else { return }
        UIApplication.shared.open(url)
    }

}

