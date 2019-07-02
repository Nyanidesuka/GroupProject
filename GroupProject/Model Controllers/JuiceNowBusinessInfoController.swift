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
        let infoDictionary: [String : Any] = ["reviewReferences" : info.juiceReviewReferences, "businessID" : info.businessID, "juiceReviewReferences" : info.juiceReviewReferences, "imageURLs" : info.imageURLs]
        return infoDictionary
    }
    
    func fetchInfoForBusiness(business: Business, completion: @escaping (JuiceNowBusinessInfo?) -> Void){
        //fetch details from yelp!
        self.fetchImageURLsFromYelp(forBusiness: business) { (imageURLs) in
            let newBusinessInfo = JuiceNowBusinessInfo(businessID: business.businessID, reviews: [], imageURLs: imageURLs)
            print("successfully created a new document for this business.")
            completion(newBusinessInfo)
        }
    }
    
    func fetchImageURLsFromYelp(forBusiness business: Business, completion: @escaping ([String]) -> Void){
        var returnArray: [String] = []
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses") else {print("couldnt make a url for the image fetch"); completion([]); return}
        let finalURL = baseURL.appendingPathComponent(business.businessID)
        print(finalURL)
        YelpService.shared.fetch(url: finalURL) { (data) in
            guard let data = data else {print("Couldnt unwrap the data we got from the image url fetch."); return}
            let decoder = JSONDecoder()
            do{
                let decodedDetails = try decoder.decode(YelpBusinessDetails.self, from: data)
                returnArray = decodedDetails.photos
                print("we have decoded \(returnArray.count) URLS for \(business.name)🔋🔋🔋")
            } catch {
                print("there was an error in \(#function) : \(error.localizedDescription)")
            }
            completion(returnArray)
        }
    }
}


