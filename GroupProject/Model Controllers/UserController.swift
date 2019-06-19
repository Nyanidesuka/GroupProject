//
//  UserController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

class UserController{
    //shared instance
    static let shared = UserController()
    private init(){}
    //keep track of the current user
    var currentUser: User? = nil
    
    //MARK: CRUD functions
    
    func createNewUser(withUsername username: String){
        let newUser = User(username: username)
        UserController.shared.currentUser = newUser
        
        UserController.shared.saveUserDocument(data: UserController.shared.createDictionary(fromUser: newUser)) { (success) in
            if success{
                print("successfully created the user document in firestore")
            } else {
                print("there was an issue creating the user document in firestore.")
            }
        }
    }
    
    func loadUser(){
        
    }
    
    func saveUserLocally(){
        
    }
    
    func deleteUser(targetUser: User){
        
    }
    
    func saveUserDocument(data: [String : Any], completion: @escaping(Bool) -> Void){
        guard let uuid = data["uuid"] as? String else {return}
        FirebaseService.shared.addDocument(documentName: uuid, collectionName: "Users", data: data) { (success) in
            if success{
                print("Successfully saved user to firebase.")
            } else {
                print("coud not save user to firebase")
            }
        }
    }
    
    func fetchUserDocument(withUUID uuid: String, completion: @escaping ([String : Any]?) -> Void){
        FirebaseService.shared.fetchDocument(documentName: uuid, collectionName: "Users") { (document) in
            guard let document = document else {completion(nil); return}
            completion(document)
        }
    }
    
    func createDictionary(fromUser user: User) -> [String : Any]{
        let businessReviewsDictionary = JuiceNowBusinessReviewController.shared.createDictionary(fromReviews: user.businessReviews)
        let juiceReviewsDictionary = JuiceReviewController.shared.createDictionary(fromJuiceReview: user.juiceReviews)
        let returnDictionary: [String : Any] = ["username" : user.username, "uuid" : user.uuid, "businessReviews" : businessReviewsDictionary, "juiceReviews" : juiceReviewsDictionary]
        
        return returnDictionary
    }
}
