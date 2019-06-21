//
//  ProductController.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import Foundation
import UIKit

class ProductController {
    
    //MARK: - Singleton
    static let sharedInstance = ProductController()
    private init() {}
    
    //MARK: - Source of truth / Properties
    var products: [Product] {
        return createMockData()
    }
    
    
}//END OF PRODUCT CONTROLLER CLASS

extension ProductController {
    func createMockData() -> [Product] {
        
        
        
        
        
        
        
        
        return []
    }
    
    func createFeaturedProducts() -> [Product] {
        let baseArray = createMockData()
        let shuffledFive = baseArray.shuffled().prefix(5)
        return Array(shuffledFive)
    }
    
    func grabBeginnerProducts() -> [Product] {
        var beginners: [Product] = []
        let products = createMockData()
        for product in products {
            if product.level == 0 {
                beginners.append(product)
            }
        }
        return beginners
    }
    
    func grabIntermediateProducts() -> [Product] {
        var intermediate: [Product] = []
        let products = createMockData()
        for product in products {
            if product.level == 1 {
                intermediate.append(product)
            }
        }
        return intermediate
    }
    
    func grabAdvancedProdcuts() -> [Product] {
        var advanced: [Product] = []
        let products = createMockData()
        for product in products {
            if product.level == 2 {
                advanced.append(product)
            }
        }
        return advanced
    }
    
}//END OF HELPER FUNC EXTENSION
