//
//  ShoppinglistController.swift
//  assessment Shopping list
//
//  Created by William Moody on 5/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import Foundation
import CoreData

class ShoppinglistController {
    
    static let shared = ShoppinglistController()
    
    //getting fteched results controller
    var fetchedRsultsController: NSFetchedResultsController<Shoppinglist>
    
    init() {
        
        //request
        let request: NSFetchRequest<Shoppinglist> = Shoppinglist.fetchRequest()
        //sortDiscriptor
        let isCompleteSortDiscripter = NSSortDescriptor(key: "isComplete", ascending: true)
        request.sortDescriptors = [isCompleteSortDiscripter]
        
        //fetchedResultController
        let resultController: NSFetchedResultsController<Shoppinglist> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "Complete", cacheName: nil)
        
        //assigning to class properties
        self.fetchedRsultsController = resultController
        do{
            try fetchedRsultsController.performFetch()
        }catch{
            print("Fetch Error \(error)")
        }
    }
    
    
    
    //CRUD
    func createItem(name: String){
        _ = Shoppinglist(name: name)
        saveToPersistence()
    }
    func deleteItem(shoppinglist: Shoppinglist){
        let moc = CoreDataStack.context
        moc.delete(shoppinglist)
        saveToPersistence()
    }
    
    func toggleCheckBox(shoppinglist: Shoppinglist){
        shoppinglist.isComplete = !shoppinglist.isComplete
        saveToPersistence()
    }
    
    //save function
    func saveToPersistence() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch  {
            print("Error saving to persistence: \(error)")
        }
        
    }
}
