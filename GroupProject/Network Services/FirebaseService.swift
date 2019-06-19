//
//  FirebaseNetworkService.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import Firebase

class FirebaseService{
    
    static let shared = FirebaseService()
    
    func addDocument(documentName document: String, collectionName collection: String, completion: @escaping (Bool) -> Void){
        FirestoreReferenceManager.root.collection(collection).document(document).setData(["test 1" : "wow for the first time"]) { (error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func fetchDocument(completion: @escaping ([[String : Any]]) -> Void){
        
    }
    
    func fetchCollection(completion: @escaping () -> Void){
        FirestoreReferenceManager.root.collection("Test Stuff").getDocuments { (documents, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion()
                return
            }
            print("got documents☑️☑️☑️☑️☑️☑️☑️☑️☑️")
            
            print(documents?.documents[0].data())
            
            completion()
            return
        }
    }
    
    func updateDocument(documentName document: String, collectionName collection: String, completion: @escaping (Bool) -> Void){
        
    }
    
    func deleteDocument(documentName document: String, collectionName collection: String, completion: @escaping (Bool) -> Void){
        
    }
    
    
}
