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
        let moc = CoreDataStack.context
        UserController.shared.currentUser = newUser
        saveToPersistentStore()
    }
    
    func loadUser(){
        let request: NSFetchRequest<User> = User.fetchRequest()
        do{
            let fetchedUsers = try CoreDataStack.context.fetch(request)
            UserController.shared.currentUser = fetchedUsers.first
        } catch {
            print("there was an error in \(#function); \(error.localizedDescription)")
        }
    }
    
    func saveToPersistentStore(){
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            print("there was an error in \(#function); \(error.localizedDescription)")
        }
    }
    
    func deleteUser(targetUser: User){
        if let moc = targetUser.managedObjectContext{
            moc.delete(targetUser)
            saveToPersistentStore()
            UserController.shared.currentUser = nil
        }
    }
    
    
}
