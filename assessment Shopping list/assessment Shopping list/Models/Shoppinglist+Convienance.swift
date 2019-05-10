//
//  Shoppinglist+Convienance.swift
//  assessment Shopping list
//
//  Created by William Moody on 5/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation
import CoreData

extension Shoppinglist {
    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
