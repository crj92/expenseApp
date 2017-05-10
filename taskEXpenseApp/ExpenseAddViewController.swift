//
//  ExpenseAddViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/27/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift

class ExpenseAddViewController: UIViewController {
    
    
    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var tblViewAdd: UITableView!
    //   @IBOutlet weak var txtfirstItem: UITextField!
    //    @IBOutlet weak var txtMoney: UITextField!
    
    var resultsTemp = [NewExpenseTemp]()
    var expenselistsTemp : Results<NewExpenseTemp>!
    var currentCreateActionTemp : UIAlertAction!
    var newExpenseTemp = NewExpenseTemp()
    let newExpense = NewExpense()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tblViewAdd.dataSource = self
        //        tblViewAdd.delegate = self
        expenselistsTemp = readTasksAndUpdateUITemp()//dis onwe shud be der to rem0ve not nil for forced wrap
        //chk why we need dis 2
        tblViewAdd.rowHeight = UITableViewAutomaticDimension
        tblViewAdd.estimatedRowHeight = 140
        
    }
    // add buttton action
    @IBAction func addItems(_ sender: Any) {
//        displayAlertToAddTaskListTemp()
        //call a vc & not an alert type view
        
    }
    //switch
    @IBAction func activateGroup(_ sender: Any) {
    }
    //button activates
    @IBAction func addMembers(_ sender: Any) {
    }
    //save button
    @IBAction func saveData(_ sender: Any) {
        newExpense.addList.append(newExpenseTemp)
        newExpense.eventTitle = txtEventName.text!
        print("eventTitle sent",newExpense.eventTitle)
        newExpense.save()
        newExpenseTemp.removeSaveTemp()
        
        //going back to prev screen when nevigation controller is in play
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    
    //chk why we need dis 1
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
//            self?.tblViewAdd.reloadData()
            self?.newExpenseTemp.removeSaveTemp()

        }
    }
    
    //opens alert to add expense and save
    func displayAlertToAddTaskListTemp() {
        
        let title = "AddNewItem"
        let doneTitle = "Add"
        
        let alertController = UIAlertController(title: title, message: "Add expense.", preferredStyle: UIAlertControllerStyle.alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.default) { (action) -> Void in
            
            let itemTemp = alertController.textFields?.first?.text
            let expenseDataTemp = alertController.textFields?[1].text
            
            
            
//            let newExpenseTemp1 = NewExpenseTemp()
            
            self.newExpenseTemp.itemNameTemp = itemTemp!
            self.newExpenseTemp.moneySpentTemp = Double(expenseDataTemp!)!
            
            self.newExpenseTemp.saveTemp()
            //                self.txtAddExpense.text = ""
            self.expenselistsTemp = self.readTasksAndUpdateUITemp()
            self.tblViewAdd.reloadData()
//            self.newExpenseTemp = newExpenseTemp1
            //clear newExpenseTemp
            //            }
            
            print(expenseDataTemp ?? "")
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        self.currentCreateActionTemp = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Enter Item"
            textField.addTarget(self, action: #selector(ExpenseAddViewController.expenseFieldDidChangeTemp(textField:)), for: UIControlEvents.editingChanged)
        }
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Enter expense"
            textField.addTarget(self, action: #selector(ExpenseAddViewController.expenseFieldDidChangeTemp(textField:)), for: UIControlEvents.editingChanged)
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func readTasksAndUpdateUITemp() -> Results<NewExpenseTemp>{
        
        return   dbRealm.objects(NewExpenseTemp.self)
        //        self.tblView.setEditing(false, animated: true)
    }
    //important needed otherwise as soon as we enter data it hangs
    func expenseFieldDidChangeTemp(textField: UITextField) {
        
        self.currentCreateActionTemp.isEnabled = (textField.text?.characters.count)! > 0
    }
    
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let _ = segue.destination as? ExpenseAddViewController
        
    }
    
}

extension ExpenseAddViewController: UITableViewDelegate{
    
    
}
extension ExpenseAddViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return expenselistsTemp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewAdd.dequeueReusableCell(withIdentifier: "CellAdd") as! NewExpenseTempTableViewCell
        let listTemp = expenselistsTemp[indexPath.row]
        print(listTemp)
        cell.txtFirstItem.text = listTemp.itemNameTemp
        cell.txtMoney.text = String(listTemp.moneySpentTemp)
        return cell
    }
}
