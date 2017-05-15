//
//  ExpenseDetailTableViewCell.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/15/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class ExpenseDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemValue: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

