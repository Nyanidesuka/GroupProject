//
//  JuiceNowBusinessInfo.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import UIKit
//this is a class of its own so we can easily use it with firebase
class JuiceNowBusinessInfo{
    
    let reviews: [JuiceNowBusinessReview]
    //let photos: [UIImage]    ;   later
    var juiceReviews: [JuiceReview] = []
    var juiceReviewReferences: [String] = []
    let businessID: String
    var imageURLs: [String]
    
    init(businessID: String, reviews: [JuiceNowBusinessReview], juiceReviewReferences: [String] = [], juiceReviews: [JuiceReview] = [], imageURLs: [String] = []){
        self.businessID = businessID
        self.reviews = reviews
        self.juiceReviews = juiceReviews
        self.juiceReviewReferences = juiceReviewReferences
        self.imageURLs = imageURLs
    }
    
    convenience init?(dictionary data: [String : Any]){
        guard let businessID = data["businessID"] as? String,
            let reviewsDictionaries = data["reviews"] as? [[String : Any]], let juiceReviewReferences = data["juiceReviewReferences"] as? [String],
        let imageURLs = data["imageURLs"] as? [String] else {print("couldn't get the data from the dictionary: \(data)"); return nil}
        let reviews = reviewsDictionaries.compactMap({return JuiceNowBusinessReview(firestoreData: $0)})
        self.init(businessID: businessID, reviews: reviews, juiceReviewReferences: juiceReviewReferences, imageURLs: imageURLs)
    }
}
