//
//  CoreDataStack.swift
//  GroupProject
//
//  Created by Haley Jones on 6/19/19.
//  Copyright © 2019 HaleyJones. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    static let container: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "JuiceNow")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let anError = error {
                fatalError("There was an error loading the persistent stores. \(anError)")
            }
        })
        return persistentContainer
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
