//
//  ShoppinglistTableViewController.swift
//  assessment Shopping list
//
//  Created by William Moody on 5/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit
import CoreData

class ShoppinglistTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppinglistController.shared.fetchedRsultsController.delegate = self
    }

    //adding items to list
    @IBAction func addListItemBarButton(_ sender: Any) {
        presentAlertController()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return ShoppinglistController.shared.fetchedRsultsController.sections?.count ?? 0
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ShoppinglistController.shared.fetchedRsultsController.sections?[section].numberOfObjects ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as? ShoppingTableViewCell else {return UITableViewCell()}
        
        let shoppinglist = ShoppinglistController.shared.fetchedRsultsController.object(at: indexPath)
        
        cell.update(withList: shoppinglist)
        cell.delegate = self
        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let shoppinglist = ShoppinglistController.shared.fetchedRsultsController.object(at: indexPath)
            ShoppinglistController.shared.deleteItem(shoppinglist: shoppinglist)
        }
    }
}

extension ShoppinglistTableViewController: ShoppingTableViewCellDelegate { 

    func toggleForCell(cell: ShoppingTableViewCell) {
        print("toggle for cell")

        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let shoppinglist = ShoppinglistController.shared.fetchedRsultsController.object(at: indexPath)
        ShoppinglistController.shared.toggleCheckBox(shoppinglist: shoppinglist)
        cell.update(withList: shoppinglist)
    }
}

extension ShoppinglistTableViewController {
    //alert controller func
    func presentAlertController(){
        let alertController = UIAlertController(title: "New Item", message: "What do you want to buy", preferredStyle: .alert)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Type Here"
            textfield.keyboardType = .default
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let addItemText = alertController.textFields?.first?.text else {return}
            
            ShoppinglistController.shared.createItem(name: addItemText)
        }
        alertController.addAction(dismissAction)
        alertController.addAction(addAction)
        self.present(alertController, animated: true, completion: nil)
    }
}



extension ShoppinglistTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
}
