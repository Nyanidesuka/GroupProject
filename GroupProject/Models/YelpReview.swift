//
//  YelpReview.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

//calling this YelpReview for clarity after we add JuiceNow reviews.
class YelpReview: Decodable{
    let id: String
    let rating: Int
    let text: String
}

struct YelpReviewTLD: Decodable{
    let reviews: [YelpReview]
}

//I'm gonna need another struct for the User who posted the review

