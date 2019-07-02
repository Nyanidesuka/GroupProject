//
//  File.swift
//  GroupProject
//
//  Created by Haley Jones on 7/2/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import Foundation

class YelpBusinessDetails: Codable{
    
    var photos: [String]
    
    enum CodingKeys: String, CodingKey{
        case photos = "photos"
    }
}

