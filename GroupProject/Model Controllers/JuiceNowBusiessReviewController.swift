//
//  JuiceNowBusiessReviewController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceNowBusinessReviewController{
    static let shared = JuiceNowBusinessReviewController()
    
    func createDictionary(fromReviews reviews: [JuiceNowBusinessReview]) -> [[String : Any]]{
        var returnArray: [[String : Any]] = []
        for review in reviews{
            let newDictionary: [String: Any] = ["username" : review.username, "text" : review.text, "rating" : review.rating]
            returnArray.append(newDictionary)
        }
        return returnArray
    }
}
