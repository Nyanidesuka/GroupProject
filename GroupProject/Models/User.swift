//
//  User.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

extension User{
    convenience init(username: String, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.username = username
        self.uuid = UUID().uuidString
    }
}
