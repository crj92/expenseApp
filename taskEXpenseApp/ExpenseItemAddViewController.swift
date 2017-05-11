//
//  ExpenseItemAddViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/4/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class ExpenseItemAddViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var tblViewAddItem: UITableView!
//    var count = 0
//    let newExpenseTemp = NewExpenseTemp()
    var currentCreateActionTemp : UIAlertAction!
    var itemTemp = ""
    var expenseDataTemp = ""
    var newExpenseTempList = [NewExpenseTemp]()//List<NewExpenseTemp>()
    let newExpense = NewExpense()
    let userLoggedIn = User()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewAddItem.dataSource = self
        tblViewAddItem.delegate = self
        
        tblViewAddItem.rowHeight = UITableViewAutomaticDimension
        tblViewAddItem.estimatedRowHeight = 140

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addItems(_ sender: Any) {
        displayAlertToAddItemListTemp()
    }
    
    @IBAction func saveData(_ sender: Any) {
        
        //going back to prev screen when nevigation controller is in play

        newExpense.eventTitle = txtName.text!
        newExpense.save()
        newExpenseTempList.removeAll()
        print(newExpenseTempList.count)
//        userLoggedName = "Shyam"
//        userLoggedIn.userName = userLoggedName
//        userLoggedIn.expenseList.append(newExpense)
//        userLoggedIn.saveUserData()
        //chk if user is already der then update or create a new one
        userLoggedIn.userName = userLoggedName
        let allUser = dbRealm.objects(User.self)
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLoggedIn.userName)
        print("the user",theUser)
        print("the user count", theUser.count)
        if theUser.count >= 1{
            let sameId = theUser.first?.id
            userLoggedIn.expenseList.append(newExpense)
            userLoggedIn.updateUserData(sameId!)//check if we can remve forced
            
        }else{
            let lastId = allUser.last?.id ?? 0

//            userLoggedIn.id += 1
            userLoggedIn.userName = userLoggedName
            userLoggedIn.expenseList.append(newExpense)
            userLoggedIn.saveUserData(lastId)
        }


        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
        self?.tblViewAddItem.reloadData()
//            self?.newExpenseTemp.removeSaveTemp()
            
        }
    }
    
    //opens alert to add expense and save
    func displayAlertToAddItemListTemp() {
        
        let title = "AddNewItem"
        let doneTitle = "Add"
        
        let alertController = UIAlertController(title: title, message: "Add expense.", preferredStyle: UIAlertControllerStyle.alert)
        let createAction = UIAlertAction(title: doneTitle, style: UIAlertActionStyle.default) { (action) -> Void in
            
            self.itemTemp = (alertController.textFields?.first?.text)!
            self.expenseDataTemp = (alertController.textFields?[1].text)!
            
            
            
            let newExpenseTemp = NewExpenseTemp()
            
            newExpenseTemp.itemNameTemp = self.itemTemp
            newExpenseTemp.moneySpentTemp = Double(self.expenseDataTemp)!
            self.newExpenseTempList.append(newExpenseTemp)
//            self.newExpenseTemp.saveTemp()
            //                self.txtAddExpense.text = ""
//            self.expenselistsTemp = self.readTasksAndUpdateUITemp()
            
            self.tblViewAddItem.reloadData()
            //            }
            
//            print(self.expenseDataTemp )
//            addTempObject in array
            self.newExpense.addList.append(newExpenseTemp)

            print(self.newExpenseTempList.count)
        }
        
        alertController.addAction(createAction)
        createAction.isEnabled = false
        self.currentCreateActionTemp = createAction
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Enter Item"
            textField.addTarget(self, action: #selector(ExpenseItemAddViewController.expenseFieldDidChangeTemp(textField:)), for: UIControlEvents.editingChanged)
        }
        alertController.addTextField { (textField) -> Void in
            textField.placeholder = "Enter expense"
            textField.addTarget(self, action: #selector(ExpenseItemAddViewController.expenseFieldDidChangeTemp(textField:)), for: UIControlEvents.editingChanged)
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func expenseFieldDidChangeTemp(textField: UITextField) {
        
        self.currentCreateActionTemp.isEnabled = (textField.text?.characters.count)! > 0
    }
    

}

extension ExpenseItemAddViewController: UITableViewDelegate{
    
    
}
extension ExpenseItemAddViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return newExpenseTempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewAddItem.dequeueReusableCell(withIdentifier: "ItemsCell") as! NewExpenseAddItemsTableViewCell
        cell.txtItemsName.text = newExpenseTempList[indexPath.row].itemNameTemp
        cell.txtItemsValue.text = String(newExpenseTempList[indexPath.row].moneySpentTemp)
        return cell
    }
}
