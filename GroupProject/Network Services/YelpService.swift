//
//  BusinessService.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class YelpService{
    //just makes calling the fetches easier.
    static let shared = YelpService()
    
    private let apiKey = "jJrfO-lbF2pzoAomVGgSEWJfet5Q5_A4QLHSWJQjnIUMgaEz_Me13kZlS2C17dv0p9t5Jp9-IYVhBSgtemKuWUlnXNGn3Q0ErPSL2NqAS61Q8ovx0wO-dYDwM8oHXXYx"
    
    //a more generic fetch that just completes with data.
    func fetch(url: URL, completion: @escaping (Data?) -> Void){
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        request.addValue("Bearer \(self.apiKey)", forHTTPHeaderField: "Authorization")
        print("doing a fetch")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            if let error = error{
                print("there was an error fetching the data.; \(error.localizedDescription)")
                completion(nil)
                return
            }
            //if we get here we have data
            completion(data)
        }).resume()
    }
    
    
    //fetch businesses based on a query. Right now it's just using a premade URL for testing purposes.
    func fetchBusinesses(completion: @escaping ([Business]) -> Void){
        
        guard let url = URL(string: "https://api.yelp.com/v3/businesses/search?term=juice&location=lehi") else {return}
        var request = URLRequest(url: url)
        request.httpBody = nil
        request.httpMethod = "GET"
        request.addValue("Bearer \(self.apiKey)", forHTTPHeaderField: "Authorization")
        print("doing a fetch")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            if let error = error{
                print("there was an error fetching the data.; \(error.localizedDescription)")
                completion([])
                return
            }
            print("Made it past error")
            //if we get here we have data
            guard let unwrappedData = data else {completion([]); return}
            let businessDecoder = JSONDecoder()
            do{
                let businessesTLD = try businessDecoder.decode(BusinessTLD.self, from: unwrappedData)
                print("\(businessesTLD.businesses.count) businesses pulled from yelp 🔵🔵🔵")
                print(businessesTLD.businesses[0].name)
                completion(businessesTLD.businesses)
            }catch{
                print("there was an error decoding the data.; \(error)")
                print(unwrappedData)
                completion([])
                return
            }
        }).resume()
    }
    
    //This one's gonna fetch reviews for a specific business.
    func fetchReviews(forBusinessID businessID: String, completion: @escaping ([YelpReview]) -> Void){
        print("starting the review fetch.")
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses") else {completion([]); return}
        print("got a base url")
        let urlPlusBusinessID = baseURL.appendingPathComponent(businessID)
        let finalURL = urlPlusBusinessID.appendingPathComponent("reviews")
        //we have a URL! Now there must be a request.
        print("Final URL: \(finalURL.absoluteString)")
        var request = URLRequest(url: finalURL)
        request.httpBody = nil
        request.httpMethod = "GET"
        request.addValue("Bearer \(self.apiKey)", forHTTPHeaderField: "Authorization")
        print("about to start the request")
        URLSession.shared.dataTask(with: request, completionHandler: { (data, _, error) in
            if let error = error{
                print("there was an error pulling the data; \(error.localizedDescription)")
                completion([])
                return
            }
            //now we've gotten here and we have data
            print("got past the error.")
            guard let unwrappedData = data else {completion([]); return}
            print("unwrapped the data.")
            let reviewDecoder = JSONDecoder()
            do{
                let reviewTLD = try reviewDecoder.decode(YelpReviewTLD.self, from: unwrappedData)
                print("\(reviewTLD.reviews.count) Reviews pulled for the business♦️")
            }catch{
                print("there was an error decoding the data. \(error)")
                completion([])
                return
            }
        }).resume()
    }
}


