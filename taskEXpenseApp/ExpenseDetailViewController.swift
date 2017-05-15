//
//  ExpenseDetailViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/27/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift

class ExpenseDetailViewController: UIViewController, UITableViewDelegate {
    
    var selectedExpense: NewExpense!
    var itemCellActive = [UITableViewCell]()
    
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
   @IBOutlet weak var tblExpenseDetailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tblExpenseDetailView.isUserInteractionEnabled = false

        
        tblExpenseDetailView.dataSource = self
        tblExpenseDetailView.delegate = self
        btnEdit.title =  "Edit"
        self.navigationItem.title = selectedExpense.eventTitle

    }

    @IBAction func editExpenseItem(_ sender: Any) {
//        tblExpenseDetailView.isUserInteractionEnabled = true
        if (btnEdit.title ==  "Edit"){
        enableEditingCell()
        }else{
//            saveEditedItemData()
        }
    }
    
    func saveEditedItemData() -> (){
        //later do this
        
    }
}

extension ExpenseDetailViewController: UITableViewDataSource{
//    var cell : UITableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedExpense.addList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblExpenseDetailView.dequeueReusableCell(withIdentifier: "tempItemCell") as! ExpenseDetailTableViewCell
        let list = selectedExpense.addList[indexPath.row]
        cell.itemName.text = list.itemNameTemp
        cell.itemValue.text = String(list.moneySpentTemp)// why describing
        cell.isUserInteractionEnabled = false
        itemCellActive.append(cell)
        return cell
    }
    func enableEditingCell(){
        for eachcell in itemCellActive{
            eachcell.isUserInteractionEnabled = true
        }
        print(itemCellActive)
        btnEdit.title =  "Save"
        
    }
    
}

