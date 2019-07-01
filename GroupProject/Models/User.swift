//
//  User.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

class User: Codable{
    
    var username: String
    var uuid: String
    var businessReviews: [JuiceNowBusinessReview]
    var juiceReviewReferences: [String]
    var juiceReviews: [JuiceReview] = []
    var bio: String
    var likedBusinesses: [Business] = []
    var photoData: Data?
    var photoReference: String?
    
    init(username: String, uuid: String = UUID().uuidString, businessReviews: [JuiceNowBusinessReview] = [], juiceReviews: [String] = [], bio: String = "All about that juice life.", likedBusinesses: [Business] = [], photoReference: String? = nil){
        self.username = username
        self.uuid = uuid
        self.businessReviews = businessReviews
        self.juiceReviewReferences = juiceReviews
        self.bio = bio
        self.likedBusinesses = likedBusinesses
        self.photoReference = photoReference
    }
    
    convenience init?(firestoreDocument: [String : Any]){
        guard let username = firestoreDocument["username"] as? String, let uuid = firestoreDocument["uuid"] as? String, let bio = firestoreDocument["bio"] as? String, let likedBusinessData = firestoreDocument["likedBusinesses"] as? [Data], let juiceReviews = firestoreDocument["juiceReviews"] as? [String] else {print("failing initializer. Somehting is nil. 💅💅💅💅💅💅"); return nil}
        let photoReference = firestoreDocument["photoReference"] as? String
        let decodedBusinesses = BusinessController.shared.decodeBusinessData(data: likedBusinessData)
        for business in decodedBusinesses{
            business.isFavorite = true
        }
        self.init(username: username, uuid: uuid, juiceReviews: juiceReviews, bio: bio, likedBusinesses: decodedBusinesses, photoReference: photoReference)
    }
}
