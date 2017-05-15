//
//  AddItemsViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/12/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
class AddItemsViewController: UIViewController{
    
    @IBOutlet weak var txtMoneySpent: UITextField!
    @IBOutlet weak var txtItemName: UITextField!
    
    var expenseListTablevc:ExpenseItemAddViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        
//        let expenseItemAddVC = storyboard?.instantiateViewController(withIdentifier: "ExpenseItemAddVC") as! ExpenseItemAddViewController
        expenseListTablevc?.itemNameTemp = txtItemName.text!
        expenseListTablevc?.itemMoneyTemp = txtMoneySpent.text!
        expenseListTablevc?.displayItemListTemp()
//        self.navigationController?.pushViewController(expenseItemAddVC, animated: true)//chk if we can use dismiss
        
        expenseListTablevc?.tblViewAddItem.reloadData()
        
//        navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
        
        

        
    }
    
    
    @IBAction func cancelView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)

    }
    


    
}
