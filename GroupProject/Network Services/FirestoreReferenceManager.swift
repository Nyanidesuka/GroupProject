//
//  FirestoreReferenceManager.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import Firebase

//This thing here just stores a bunch of constants that have references to things we need to use firestore
struct FirestoreReferenceManager {
    //the name of our collection in our database
    static let environment = "JuiceNow"
    static let database = Firestore.firestore()
    static let root = database.collection(environment).document(environment)
}
