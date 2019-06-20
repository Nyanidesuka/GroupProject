//
//  Business.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class Business: Decodable{
    let name: String
    let isClosed: Bool
    let businessID: String
    var imageURLs: [String] = []
    var hours: [OpenHours] = []
    var rating: Double
    let latitude: Double
    let longitude: Double
    let city: String
    let state: String
    let address1: String
    let address2: String
    let address3: String
    let zip: String
    let distance: Double
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case isClosed = "is_closed"
        case businessID = "id"
        case rating = "rating"
        case latitude = "latitude"
        case longitude = "longitude"
        case city = "city"
        case state = "state"
        case address1 = "address1"
        case address2 = "address2"
        case address3 = "address3"
        case zip = "zip_code"
        case distance = "distance"
    }
}
//the yelp API hands back a dictionary with key "businesses" which is full of string-any dictionaries so we need this TLD.
struct BusinessTLD: Decodable{
    let businesses: [Business]
}

struct StoreHours: Decodable{
    let isOvernight: Bool
    let start: String
    let end: String
    let day: Int
    
    enum CodingKeys: String, CodingKey{
        case isOvernight = "is_overnight"
        case start = "start"
        case end = "end"
        case day = "day"
    }
}

struct BusinessDetailTLD: Decodable{
    let photos: [String]
    let hours: [OpenHours]
}

struct OpenHours: Decodable{
    let open: [StoreHours]
}

struct Coordinates: Decodable {
    
}

struct Location: Decodable {
    
}

//REFERENCE: https://www.yelp.com/developers/documentation/v3/business_search
