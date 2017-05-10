//
//  NewExpenseTableViewCell.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/3/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class NewExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTotalMoneySpent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
