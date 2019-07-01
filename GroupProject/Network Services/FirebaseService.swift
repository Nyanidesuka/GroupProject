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
    
    func addDocument(documentName document: String, collectionName collection: String, data: [String : Any], completion: @escaping (Bool) -> Void){
        FirestoreReferenceManager.root.collection(collection).document(document).setData(data) { (error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func fetchDocument(documentName: String, collectionName: String, completion: @escaping ([String : Any]?) -> Void){
        let docRef = FirestoreReferenceManager.root.collection(collectionName).document(documentName)
        docRef.getDocument { (document, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let document = document else {completion(nil); return}
            completion(document.data())
        }
    }
    
    func fetchCollection(completion: @escaping () -> Void){
        FirestoreReferenceManager.root.collection("Test Stuff").getDocuments { (documents, error) in
            if let error = error{
                print("there was an error in \(#function); \(error.localizedDescription)")
                completion()
                return
            }
            print("got documents☑️☑️☑️☑️☑️☑️☑️☑️☑️")
            completion()
            return
        }
    }
    
    func updateDocument(documentName document: String, collectionName collection: String, completion: @escaping (Bool) -> Void){
        
    }
    
    func deleteDocument(documentName document: String, collectionName collection: String, completion: @escaping (Bool) -> Void){
        
    }
    
    func fetchReviewsForBusiness(business: Business, completion: @escaping ([[String : Any]]) -> Void){
        let reviewsRef = FirestoreReferenceManager.root.collection("JuiceNow Reviews")
        reviewsRef.whereField("businessID", isEqualTo: business.businessID)
        print("trying to getDocuments 🔶🔶🔶")
        reviewsRef.getDocuments { (documents, error) in
            print("in getDocuments completion🔶🔶🔶")
            if let error = error{
                print("Couldn't get any documents with this fetch. \(error)")
                completion([])
                return
            }
            guard let documents = documents else {print("couldnt unwrap the documents"); return}
            var completionArray: [[String : Any]] = []
            for document in documents.documents{
                completionArray.append(document.data())
            }
            completion(completionArray)
        }
    }
}
