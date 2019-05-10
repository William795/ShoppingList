//
//  CoreDataStack.swift
//  assessment Shopping list
//
//  Created by William Moody on 5/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let persistantContainer = NSPersistentContainer(name: "assessment Shopping list")
        persistantContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error{
                fatalError("Unresolved error \(error)")
            }
        })
        return persistantContainer
    }()
    static var context: NSManagedObjectContext { return container.viewContext}
}
