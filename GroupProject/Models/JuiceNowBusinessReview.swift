//
//  JuiceNowReview.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceNowBusinessReview: Codable{
    
    let username: String
    let text: String
    var rating: Int
    //DO WE NEED A BUSINESS ID OR OTHER IDENTIFIER HERE?
    
    init(username: String, text: String, rating: Int){
        self.username = username
        self.text = text
        self.rating = rating
    }
    
    convenience init?(firestoreData data: [String: Any]){
        guard let username = data["username"] as? String,
            let text = data["text"] as? String,
            let rating = data["rating"] as? Int else {print("\(#function) in juicenowbusinessreview couldnt get the info from the dictionary: \(data)"); return nil}
        self.init(username: username, text: text, rating: rating)
    }
}//END OF CLASS
