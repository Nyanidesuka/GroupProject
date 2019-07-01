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
    var currentUser: User?
    
    //MARK: CRUD functions
    
    func createNewUser(withUsername username: String, completion: @escaping () -> Void){
        let newUser = User(username: username)
        UserController.shared.currentUser = newUser
        //save the user locally
        saveUserLocally(user: newUser)
        //save the user to firestore
        UserController.shared.saveUserDocument(data: UserController.shared.createDictionary(fromUser: newUser)) { (success) in
            if success{
                print("successfully created the user document in firestore")
            } else {
                print("there was an issue creating the user document in firestore.")
            }
            completion()
        }
    }
    
    func getFileURL() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let fileName = "userID.json"
        return documentsDirectory.appendingPathComponent(fileName)
    }
    
    func loadUser(completion: @escaping () -> Void){
        //needs to check if there's a userID saved, if there is then pull the record.
        let userDecoder = JSONDecoder()
        do{
            let userIDData = try Data(contentsOf: getFileURL())
            print("🥇 got data")
            let decodedUser = try userDecoder.decode(User.self, from: userIDData)
            let userID = decodedUser.uuid
            print("We decoded it.")
            //now we have the ID. let's fetch the user.
            FirebaseService.shared.fetchDocument(documentName: userID, collectionName: "Users") { (document) in
                guard let unwrappedDocuent = document else {
                    print("couldn't unwrap doccument 🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️")
                    let userDictionary = UserController.shared.createDictionary(fromUser: decodedUser)
                    FirebaseService.shared.addDocument(documentName: decodedUser.uuid, collectionName: "Users", data: userDictionary, completion: { (success) in
                        print("completion of making a new user doc🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️")
                        if success{
                            UserController.shared.currentUser = decodedUser
                            completion()
                        }
                    })
                    
                    return
                }
                let loadedUser = User(firestoreDocument: unwrappedDocuent)
                UserController.shared.currentUser = loadedUser
                print("loaded a user! \(loadedUser?.username)🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️🙆‍♀️")
                print(loadedUser?.likedBusinesses.first?.name)
                completion()
            }
        }catch{
            print("🥇🥇🥇There is no user to load. Creating a new user; \(error.localizedDescription)")
            let newUser = User(username: "Juicer")
            self.createNewUser(withUsername: newUser.username) {
                completion()
            }
            completion()
        }
    }
    
    func saveUserLocally(user: User){
        let userEncoder = JSONEncoder()
        do{
            let encodedID = try userEncoder.encode(user)
            try encodedID.write(to: getFileURL())
            print("we did it. it encoded. 🥇🥇🥇")
        }catch{
            print("🥇🥇🥇🥇🥇🥇🥇🥇there was a problem encoding the data: \(error.localizedDescription)")
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
    //hi, remember to make the user's profile pic its own firestore document later
    func createDictionary(fromUser user: User) -> [String : Any]{
        let businessReviewsDictionary = JuiceNowBusinessReviewController.shared.createDictionary(fromReviews: user.businessReviews)
        let likedBusinessData = BusinessController.shared.convertBusinessesToJson(businesses: user.likedBusinesses)
        let returnDictionary: [String : Any] = ["username" : user.username, "uuid" : user.uuid, "bio" : user.bio, "businessReviews" : businessReviewsDictionary, "juiceReviews" : user.juiceReviewReferences, "likedBusinesses" : likedBusinessData, "photoReference" : user.photoReference]
        return returnDictionary
    }
}
