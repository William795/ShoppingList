//
//  ShoppingTableViewCell.swift
//  assessment Shopping list
//
//  Created by William Moody on 5/10/19.
//  Copyright © 2019 William Moody. All rights reserved.
//

import UIKit

//protocol
protocol ShoppingTableViewCellDelegate: class {
    func toggleForCell(cell: ShoppingTableViewCell)
}


class ShoppingTableViewCell: UITableViewCell {

 
    @IBOutlet weak var listItemNameLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    weak var delegate: ShoppingTableViewCellDelegate?
    
    @IBAction func checkboxButtonTapped(_ sender: UIButton) {
        print("button tapped")

        delegate?.toggleForCell(cell: self)
    }
    
    func updateButton(_ isComplete: Bool) {
        
        let imageName = isComplete ? "CheckedBox" : "BlankBox"
        
        checkboxButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension ShoppingTableViewCell {
    
    // func to update all cell properties
    func update(withList shoppinglist: Shoppinglist) {
        
        updateButton(shoppinglist.isComplete)
        listItemNameLabel.text = shoppinglist.name
    }
}
