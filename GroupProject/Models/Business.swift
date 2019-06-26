//
//  Business.swift
//  GroupProject
//
//  Created by Haley Jones on 6/17/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class Business: Codable{
    let name: String
    let isClosed: Bool
    let businessID: String
    var imageURLs: [String] = []
    let baseImage: String
    var hours: [OpenHours] = []
    var rating: Double
    let coordinates: Coordinates
    let location: Location
    let distance: Double
    var yelpReviews: [YelpReview] = []
    var juiceNowReviews: [JuiceNowBusinessReview] = []
    //thinking we might need this so we can do things like appending new reviews and ratings
    var juiceNowInfoReference: JuiceNowBusinessInfo? = nil
    var isFavorite: Bool = false
    var userRating: Int? = 1
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case isClosed = "is_closed"
        case businessID = "id"
        case baseImage = "image_url"
        case rating = "rating"
        case distance = "distance"
        case coordinates = "coordinates"
        case location = "location"
        case userRating = "userRating"
    }
}
//the yelp API hands back a dictionary with key "businesses" which is full of string-any dictionaries so we need this TLD.
struct BusinessTLD: Codable{
    let businesses: [Business]
}

struct StoreHours: Codable{
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

struct BusinessDetailTLD: Codable{
    let photos: [String]
    let hours: [OpenHours]
}

struct OpenHours: Codable{
    let open: [StoreHours]
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct Location: Codable {
    let city: String
    let state: String
    let addressOne: String
    let addressTwo: String?
    let addressThree: String?
    let zipCode: String

    enum CodingKeys: String, CodingKey{
        case city = "city"
        case addressOne = "address1"
        case addressTwo = "address2"
        case addressThree = "address3"
        case state = "state"
        case zipCode = "zip_code"
    }
}

//REFERENCE: https://www.yelp.com/developers/documentation/v3/business_search

