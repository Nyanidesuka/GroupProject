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
    
    func fetchInfoForBusiness(business: Business, completion: @escaping ([String : Any]) -> Void){
        let docName = business.businessID
        FirebaseService.shared.fetchDocument(documentName: docName, collectionName: "Businesses") { (document) in
            if let unwrappedDocument = document{
                //if we're here, the document from firestore exists.
                guard let businessDetails = JuiceNowBusinessInfo(dictionary: unwrappedDocument) else {return}
                BusinessController.shared.addJuiceNowBusinessInfo(businessInfo: businessDetails, toBusiness: business)
            } else {
                //if we get here, the document did not exist in firestore
                
            }
        }
    }
    
    
    //this function is gonna let us grab more details to put into the business. Hours, photo URLs
    func fetchYelpDetails(forBusiness business: Business, completion: @escaping (JuiceNowBusinessInfo?) -> Void){
        //build a URL
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses") else {completion(nil); return}
        let finalURL = baseURL.appendingPathComponent(business.businessID)
        YelpService.shared.fetch(url: finalURL) { (data) in
            guard let unwrappedData = data else {completion(nil); return}
            let detailDecoder = JSONDecoder()
            do{
                let detailTLD = try detailDecoder.decode(BusinessDetailTLD.self, from: unwrappedData)
                print(detailTLD.photos.count)
                print(detailTLD.photos[0])
                business.hours = detailTLD.hours
                business.imageURLs = detailTLD.photos
                completion(nil)
            }catch{
                print("there was an error decoding the data.; \(error)")
                print(unwrappedData)
                completion(nil)
                return
            }
        }
    }
}
