//
//  BusinessController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class BusinessController {
    
    //MARK: - Singleton
    static let shared = BusinessController()
    private init() {}
    
    //MARK: - Properties/Source of truth for localized businesses
    var businesses: [Business] = []
    let baseBusinessURL = "https://api.yelp.com/v3/businesses/search"
    
    //MARK: - Firestore Fetching
    func fetchBusinessesFromYelp(location: String, completion: @escaping ([Business]) -> Void){
        //build the URL
        guard let baseURL = URL(string: baseBusinessURL) else {return}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: "term", value: "juice")
        let locationQueryItem = URLQueryItem(name: "location", value: location)
        components?.queryItems = [categoryQueryItem, locationQueryItem]
        guard let finalURL = components?.url else { return }
        print(finalURL)
        //pass the url to the yelp service, so it'll run a thing.
        YelpService.shared.fetch(url: finalURL) { (data) in
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
    
    func addJuiceNowBusinessInfo(businessInfo: JuiceNowBusinessInfo, toBusiness: Business){
        
    }
    
}
