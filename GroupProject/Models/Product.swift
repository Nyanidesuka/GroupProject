//
//  Product.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/21/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import Foundation
import UIKit

class Product {
    let image: UIImage
    let name: String
    let rating: Double
    let reviews: Int
    let description: String
    //level refers to beginner(0), intermediate(1), or advanced(2)
    let level: Int
    
    init(image: UIImage, name: String, rating: Double, reviews: Int, description: String, level: Int) {
        self.image = image
        self.name = name
        self.rating = rating
        self.reviews = reviews
        self.description = description
        self.level = level
    }
}//END OF PRODUCT MODEL
