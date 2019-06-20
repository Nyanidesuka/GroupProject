//
//  JuiceReview.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceReview: Codable{
    
    let businessID: String
    let businessName: String
    let drinkName: String
    let drinkPrice: Float
    let drinkRating: Int
    let drinkReview: String
    let dimension1: Int
    let dimension2: Int
    let dimension3: Int
    let dimension4: Int
    let dimension5: Int
    
    init(businessID: String, businessName: String, drinkName: String, drinkPrice: Float, drinkRating: Int, drinkReview: String, dimension1: Int, dimension2: Int, dimension3: Int, dimension4: Int, dimension5: Int){
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
    }
    
    convenience init?(firestoreData data: [String : Any]) {
        guard let businessID = data["businessID"] as? String,
            let businessName = data["businessName"] as? String,
            let drinkName = data["drinkName"] as? String,
            let drinkPrice = data["drinkPrice"] as? Float,
            let drinkRating = data["drinkRating"] as? Int,
            let drinkReview = data["drinkReview"] as? String,
            let dimension1 = data["dimension1"] as? Int,
            let dimension2 = data["dimension2"] as? Int,
            let dimension3 = data["dimension3"] as? Int,
            let dimension4 = data["dimension4"] as? Int,
            let dimension5 = data["dimension5"] as? Int else {print("couldnt get the info from the dictionary: \(data)"); return nil}
        
        self.init(businessID: businessID, businessName: businessName, drinkName: drinkName, drinkPrice: drinkPrice, drinkRating: drinkRating, drinkReview: drinkReview, dimension1: dimension1, dimension2: dimension2, dimension3: dimension3, dimension4: dimension4, dimension5: dimension5)
    }
}//END OF JUICE REVIEW CLASS

