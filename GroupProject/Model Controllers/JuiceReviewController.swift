//
//  JuiceReviewController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceReviewController{
    static let shared = JuiceReviewController()
    
    func createDictionary(fromJuiceReview reviews: [JuiceReview]) -> [[String : Any]]{
        var returnArray: [[String : Any]] = []
        for review in reviews{
            let reviewDictionary: [String : Any] = ["businessID" : review.businessID, "businessName" : review.businessName, "drinkName" : review.drinkName, "drinkPrice" : review.drinkPrice, "drinkRating" : review.drinkRating, "drinkReview" : review.drinkReview, "dimension1" : review.dimension1, "dimension2" : review.dimension2, "dimension3" : review.dimension3, "dimension4" : review.dimension4, "dimension5" : review.dimension5]
            returnArray.append(reviewDictionary)
        }
        return returnArray
    }
}
