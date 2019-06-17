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
    
    enum CodingKeys: String, CodingKey{
        case name = "name"
        case isClosed = "is_closed"
        case businessID = "id"
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
