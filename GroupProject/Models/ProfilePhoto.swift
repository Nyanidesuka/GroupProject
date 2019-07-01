//
//  ProfilePhoto.swift
//  GroupProject
//
//  Created by Haley Jones on 7/1/19.
//  Copyright © 2019 DustinKoch. All rights reserved.
//

import Foundation

class ProfilePhoto{
    var uuid: String
    var imageData: Data
    
    init(uuid: String = UUID().uuidString, imageData: Data){
        self.uuid = uuid
        self.imageData = imageData
    }
}
