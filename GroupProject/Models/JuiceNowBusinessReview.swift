//
//  JuiceNowReview.swift
//  GroupProject
//
//  Created by Haley Jones on 6/18/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation

class JuiceNowBusinessReview{
    
    let username: String
    let text: String
    
    init(username: String, text: String){
        self.username = username
        self.text = text
    }
    
    convenience init?(firestoreData data: [String: Any]){
        guard let username = data["username"] as? String,
            let text = data["text"] as? String else {print("couldnt get the info from the dictionary: \(data)"); return nil}
        self.init(username: username, text: text)
    }
    
}
