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
        //save the user locally
        saveUserLocally(userID: newUser.uuid)
        //save the user to firestore
        UserController.shared.saveUserDocument(data: UserController.shared.createDictionary(fromUser: newUser)) { (success) in
            if success{
                print("successfully created the user document in firestore")
            } else {
                print("there was an issue creating the user document in firestore.")
            }
        }
    }
    
    func getFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "userID.json"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func loadUser(){
        //needs to check if there's a userID saved, if there is then pull the record.
        let userDecoder = JSONDecoder()
        do{
            let userIDData = try Data(contentsOf: getFileURL())
            let userID = try userDecoder.decode(String.self, from: userIDData)
            //now we have the ID. let's fetch the user.
            FirebaseService.shared.fetchDocument(documentName: userID, collectionName: "Users") { (document) in
                guard let unwrappedDocuent = document else {return}
                let loadedUser = User(firestoreDocument: unwrappedDocuent)
                UserController.shared.currentUser = loadedUser
            }
        }catch{
            print("There is no user to load. Creating a new user; \(error.localizedDescription)")
            let newUser = User(username: "Juicer")
            self.createNewUser(withUsername: newUser.username)
        }
    }
    
    func saveUserLocally(userID: String){
        let userEncoder = JSONEncoder()
        do{
            let encodedID = try userEncoder.encode(userID)
            try encodedID.write(to: getFileURL())
        }catch{
            print("there was a problem encoding the data: \(error.localizedDescription)")
        }
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
        let returnDictionary: [String : Any] = ["username" : user.username, "uuid" : user.uuid, "bio" : user.bio, "businessReviews" : businessReviewsDictionary, "juiceReviews" : juiceReviewsDictionary]
        
        return returnDictionary
    }
}
