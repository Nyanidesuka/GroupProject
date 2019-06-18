//
//  Recipe.swift
//  GroupProject
//
//  Created by Dustin Koch on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    let name: String
    let image: UIImage
    let ingredients: String
    
    init(name: String, image: UIImage, ingredients: String) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
    }
}//END OF RECIPE CLASS
