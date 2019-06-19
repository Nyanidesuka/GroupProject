//
//  JuiceNowBusinessInfoController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceNowBusinessInfoController{
    static let shared = JuiceNowBusinessInfoController()
    
    func createDictionary(fromInfo info: JuiceNowBusinessInfo) -> [String : Any]{
        let reviewsAsDictionaries = JuiceNowBusinessReviewController.shared.createDictionary(fromReviews: info.reviews)
        let infoDictionary: [String : Any] = ["reviews" : reviewsAsDictionaries, "businessID" : info.businessID]
        return infoDictionary
    }
}
