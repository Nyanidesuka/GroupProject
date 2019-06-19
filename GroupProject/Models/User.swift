//
//  User.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

class User{
    
    var username: String
    var uuid: String
    var businessReviews: [JuiceNowBusinessReview]
    var juiceReviews: [JuiceReview]
    
    init(username: String, uuid: String = UUID().uuidString, businessReviews: [JuiceNowBusinessReview] = [], juiceReviews: [JuiceReview] = []){
        self.username = username
        self.uuid = uuid
        self.businessReviews = businessReviews
        self.juiceReviews = juiceReviews
    }
    
    convenience init?(firestoreDocument: [String : Any]){
        guard let username = firestoreDocument["username"] as? String, let uuid = firestoreDocument["uuid"] as? String else {return nil}
        self.init(username: username, uuid: uuid)
    }
}
