//
//  BusinessController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class BusinessController{
    static let shared = BusinessController()
    
    func fetchBusinessesFromYelp(completion: @escaping ([Business]) -> Void){
        //build the URL
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses/search?term=juice&location=lehi") else {return}
        //pass the url to the yelp service, so it'll run a thing.
        YelpService.shared.fetch(url: baseURL) { (data) in
            guard let unwrappedData = data else {completion([]); return}
            let businessDecoder = JSONDecoder()
            do{
                let businessesTLD = try businessDecoder.decode(BusinessTLD.self, from: unwrappedData)
                print(businessesTLD.businesses.count)
                print(businessesTLD.businesses[0].name)
                completion(businessesTLD.businesses)
            }catch{
                print("there was an error decoding the data.; \(error)")
                print(unwrappedData)
                completion([])
                return
            }
        }
    }
    //this function is gonna let us grab more details to put into the business. Hours, photo URLs
    func fetchYelpDetails(forBusiness business: Business, completion: @escaping (Bool) -> Void){
        //build a URL
        guard let baseURL = URL(string: "https://api.yelp.com/v3/businesses") else {completion(false); return}
        let finalURL = baseURL.appendingPathComponent(business.businessID)
        YelpService.shared.fetch(url: finalURL) { (data) in
            guard let unwrappedData = data else {completion(false); return}
            let detailDecoder = JSONDecoder()
            do{
                let detailTLD = try detailDecoder.decode(BusinessDetailTLD.self, from: unwrappedData)
                print(detailTLD.photos.count)
                print(detailTLD.photos[0])
                business.hours = detailTLD.hours
                business.imageURLs = detailTLD.photos
                completion(true)
            }catch{
                print("there was an error decoding the data.; \(error)")
                print(unwrappedData)
                completion(false)
                return
            }
        }
    }
}
