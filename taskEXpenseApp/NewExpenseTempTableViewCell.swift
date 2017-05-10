//
//  NewExpenseTempTableViewCell.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/27/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class NewExpenseTempTableViewCell: UITableViewCell {

    @IBOutlet weak var txtFirstItem: UITextField!
    @IBOutlet weak var txtMoney: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
