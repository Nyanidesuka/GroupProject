//
//  BusinessController.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreLocation

class BusinessController {
    
    //MARK: - Singleton
    static let shared = BusinessController()
    private init() {}
    
    //source of Truth
    var fetchedBusinesses: [Business] = []
    
    //MARK: - Properties/Source of truth for localized businesses
    var businesses: [Business] = []
    let baseBusinessURL = "https://api.yelp.com/v3/businesses/search"
    
    //MARK: - Firestore Fetching
    func fetchBusinessesFromYelp(location: String, completion: @escaping ([Business]) -> Void){
        //build the URL
        guard let baseURL = URL(string: baseBusinessURL) else {return}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: "categories", value: "juicebars,all")
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
    //this fetch works off latitude and longitude instead of a search term. requires corelocation
    func fetchBusinessWithCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping ([Business]) -> Void){
        guard let baseURL = URL(string: baseBusinessURL) else {completion([]); return}
        let categoryQuery = URLQueryItem(name: "categories", value: "juicebars,all")
        let latitudeQuery = URLQueryItem(name: "latitude", value: "\(latitude)")
        let longitudeQuery = URLQueryItem(name: "longitude", value: "\(longitude)")
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        components?.queryItems = [categoryQuery, latitudeQuery, longitudeQuery]
        guard let finalURL = components?.url else {completion([]); return}
        print(finalURL)
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
    
    //a function that takes i a business and some juicenow info and will append the juicenow info to the business.
    func addJuiceNowBusinessInfo(businessInfo: JuiceNowBusinessInfo, toBusiness business: Business){
        business.juiceNowReviews = businessInfo.reviews
        business.juiceNowInfoReference = businessInfo
    }
}

