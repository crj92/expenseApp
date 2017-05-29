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
    
    var oldMoneySpent = ""
    var oldItemName = ""
    
    var expenseListTablevc:ExpenseItemAddViewController?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(expenseListTablevc?.isRowGettingEdited == true){// if row gets edited.. populate the fields with selected table row
            txtItemName.text = oldItemName
            txtMoneySpent.text = oldMoneySpent
        }
    }
    
    
    @IBAction func addItem(_ sender: Any) {
        
//        let expenseItemAddVC = storyboard?.instantiateViewController(withIdentifier: "ExpenseItemAddVC") as! ExpenseItemAddViewController
        print(expenseListTablevc?.context)
        if((expenseListTablevc?.context == "editedExpense") || (expenseListTablevc?.context == "addNewExpense")){
            expenseListTablevc?.isAddItemUpdate = true// if this den new item added
        }
//        else if(expenseListTablevc?.context == "addNewExpense"){
//            expenseListTablevc?.context = "fromAddItemsVC"
////            expenseListTablevc?.context = "addNewExpense"
//        }else{
//            print("some other context")
//            expenseListTablevc?.context = "fromAddItemsVC"
//
//        }
//        expenseListTablevc?.context = "fromAddItemsVC"
        expenseListTablevc?.itemNameTemp = txtItemName.text!
        expenseListTablevc?.itemMoneyTemp = txtMoneySpent.text!
        expenseListTablevc?.displayItemListTemp(txtItemName.text!)
        
        expenseListTablevc?.tblViewAddItem.reloadData()
        
//        navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
        
        

        
    }
    
    
    @IBAction func cancelView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)

    }
    


    
}
