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
    //let juiceReviews: [JuiceReview]    ;   later
    let businessID: String
    
    init(businessID: String, reviews: [JuiceNowBusinessReview]){
        self.businessID = businessID
        self.reviews = reviews
    }
    
    convenience init?(firestoreData data: [String : Any]){
        guard let businessID = data["businessID"] as? String,
            let reviewsDictionaries = data["reviews"] as? [[String : Any]] else {print("couldn't get the data from the dictionary: \(data)"); return nil}
        let reviews = reviewsDictionaries.compactMap({return JuiceNowBusinessReview(firestoreData: $0)})
        self.init(businessID: businessID, reviews: reviews)
    }
    
    
    
}
