//
//  YelpReviewController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class YelpReviewController{
    static let shared = YelpReviewController()
    
    func fetchYelpReviews(forBusinessID businessID: String, completion: @escaping ([YelpReview]) -> Void){
        //build a URL
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses") else {completion([]); return}
        print("got a base url")
        let urlPlusBusinessID = baseURL.appendingPathComponent(businessID)
        let finalURL = urlPlusBusinessID.appendingPathComponent("reviews")
        //we have a URL! Now there must be a request.
        print("Final URL: \(finalURL.absoluteString)")
        YelpService.shared.fetch(url: finalURL) { (data) in
            guard let unwrappedData = data else {completion([]); return}
            print("unwrapped the data.")
            let reviewDecoder = JSONDecoder()
            do{
                let reviewTLD = try reviewDecoder.decode(YelpReviewTLD.self, from: unwrappedData)
                print(reviewTLD.reviews.count)
                completion(reviewTLD.reviews)
            }catch{
                print("there was an error decoding the data. \(error)")
                completion([])
                return
            }
        }
    }
}


