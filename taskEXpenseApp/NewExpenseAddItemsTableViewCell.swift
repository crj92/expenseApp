//
//  NewExpenseAddItemsTableViewCell.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/4/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class NewExpenseAddItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var txtItemsName: UITextField!
    @IBOutlet weak var txtItemsValue: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
