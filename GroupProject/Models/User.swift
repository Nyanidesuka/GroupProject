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
    var juiceReviews: [JuiceReview]
    var bio: String
    var likedBusinesses: [Business] = []
    var photoData: Data?
    
    init(username: String, uuid: String = UUID().uuidString, businessReviews: [JuiceNowBusinessReview] = [], juiceReviews: [JuiceReview] = [], bio: String = "All about that juice life.", likedBusinesses: [Business] = [], photoData: Data? = nil){
        self.username = username
        self.uuid = uuid
        self.businessReviews = businessReviews
        self.juiceReviews = juiceReviews
        self.bio = bio
        self.likedBusinesses = likedBusinesses
        self.photoData = photoData
    }
    
    convenience init?(firestoreDocument: [String : Any]){
        guard let username = firestoreDocument["username"] as? String, let uuid = firestoreDocument["uuid"] as? String, let bio = firestoreDocument["bio"] as? String, let likedBusinessData = firestoreDocument["likedBusinesses"] as? [Data], let photoData = firestoreDocument["photoData"] as? Data else {print("failing initializer. Somehting is nil."); return nil}
        let decodedBusinesses = BusinessController.shared.decodeBusinessData(data: likedBusinessData)
        self.init(username: username, uuid: uuid, bio: bio, likedBusinesses: decodedBusinesses, photoData: photoData)
    }
}
