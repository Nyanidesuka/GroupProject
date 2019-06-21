//
//  JuiceNowBusinessInfoController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceNowBusinessInfoController{
    static let shared = JuiceNowBusinessInfoController()
    
    func createDictionary(fromInfo info: JuiceNowBusinessInfo) -> [String : Any]{
        let reviewsAsDictionaries = JuiceNowBusinessReviewController.shared.createDictionary(fromReviews: info.reviews)
        let infoDictionary: [String : Any] = ["reviews" : reviewsAsDictionaries, "businessID" : info.businessID]
        return infoDictionary
    }
    
    func fetchInfoForBusiness(business: Business, completion: @escaping (Bool) -> Void){
        let docName = business.businessID
        FirebaseService.shared.fetchDocument(documentName: docName, collectionName: "Businesses") { (document) in
            if let unwrappedDocument = document{
                //if we're here, the document from firestore exists.
                guard let businessDetails = JuiceNowBusinessInfo(dictionary: unwrappedDocument) else {completion(false); return}
                BusinessController.shared.addJuiceNowBusinessInfo(businessInfo: businessDetails, toBusiness: business)
                completion(true)
            } else {
                
                //if we get here, the document did not exist in firestore
                let newBusinessInfo = JuiceNowBusinessInfo(businessID: business.businessID, reviews: [])
                let newBusinessInfoDictionary = JuiceNowBusinessInfoController.shared.createDictionary(fromInfo: newBusinessInfo)
                FirebaseService.shared.addDocument(documentName: business.businessID, collectionName: "Businesses", data: newBusinessInfoDictionary, completion: { (success) in
                    if success{
                        print("successfully created a new document for this business.")
                        completion(true)
                    } else {
                        print("could not create a document for this business.")
                    }
                })
                BusinessController.shared.addJuiceNowBusinessInfo(businessInfo: newBusinessInfo, toBusiness: business)
            }
        }
    }
    
}

