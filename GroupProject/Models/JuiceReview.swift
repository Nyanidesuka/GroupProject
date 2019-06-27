//
//  JuiceReview.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import UIKit

class JuiceReview: Codable{
    
    let businessID: String
    let businessName: String
    var drinkName: String
    var drinkPrice: String
    var drinkRating: Int
    var drinkReview: String
    var dimension1: Int
    var dimension2: Int
    var dimension3: Int
    var dimension4: Int
    var dimension5: Int
    var image: Data?
    
    init(businessID: String, businessName: String, drinkName: String, drinkPrice: String, drinkRating: Int, drinkReview: String, dimension1: Int, dimension2: Int, dimension3: Int, dimension4: Int, dimension5: Int, image: Data? = nil){
        self.businessID = businessID
        self.businessName = businessName
        self.drinkName = drinkName
        self.drinkPrice = drinkPrice
        self.drinkRating = drinkRating
        self.drinkReview = drinkReview
        self.dimension1 = dimension1
        self.dimension2 = dimension2
        self.dimension3 = dimension3
        self.dimension4 = dimension4
        self.dimension5 = dimension5
        self.image = image
    }
    
    convenience init?(firestoreData data: [String : Any]) {
        guard let businessID = data["businessID"] as? String,
            let businessName = data["businessName"] as? String,
            let drinkName = data["drinkName"] as? String,
            let drinkPrice = data["drinkPrice"] as? String,
            let drinkRating = data["drinkRating"] as? Int,
            let drinkReview = data["drinkReview"] as? String,
            let dimension1 = data["dimension1"] as? Int,
            let dimension2 = data["dimension2"] as? Int,
            let dimension3 = data["dimension3"] as? Int,
            let dimension4 = data["dimension4"] as? Int,
            let dimension5 = data["dimension5"] as? Int,
            let imageData = data["image"] as? Data else {print("couldnt get the info from the dictionary: \(data)"); return nil}
        self.init(businessID: businessID, businessName: businessName, drinkName: drinkName, drinkPrice: drinkPrice, drinkRating: drinkRating, drinkReview: drinkReview, dimension1: dimension1, dimension2: dimension2, dimension3: dimension3, dimension4: dimension4, dimension5: dimension5, image: imageData)
    }
}//END OF JUICE REVIEW CLASS

