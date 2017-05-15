//
//  ExpenseItemAddViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/4/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift
// master version2 branch
class ExpenseItemAddViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var tblViewAddItem: UITableView!
    var itemNameTemp = ""
    var itemMoneyTemp = ""
    var newExpenseTempList = List<NewExpenseTemp>()
    var newExpenseList = List<NewExpense>()
//    var anotherTempObj: NewExpenseTemp?
    let userLoggedIn = User()
    let newExpense = NewExpense()//trying again
//    var addingItemsViewController: AddingItemsViewController?
//    var dayItemCreated: NSDate{
//        return Date().currentDateTime
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblViewAddItem.dataSource = self
        tblViewAddItem.delegate = self
        
        tblViewAddItem.rowHeight = UITableViewAutomaticDimension
        tblViewAddItem.estimatedRowHeight = 140
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        displayItemListTemp()
//        self.tblViewAddItem.reloadData()

    }
    
    
    @IBAction func addItems(_ sender: Any) {
//        displayAlertToAddItemListTemp()
//        getAddItemsPopViewController(sender)
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? AddItemsViewController{
            destination.expenseListTablevc = self
        }
    }


    
    @IBAction func saveData(_ sender: Any) {
//        let newExpense = NewExpense()// global this helps to persist temp into expense
        newExpense.eventTitle = txtName.text!
//        newExpense.addList.append(anotherTempObj!)
        newExpense.totalMoneySpent = newExpense.addAllExpense()
        newExpense.dateCreated = NSDate()
        print(newExpense.dateCreated)
//        newExpense.setTime
        //chk if user is already der then update or create a new one
        userLoggedIn.userName = userLoggedId
        
        let allUser = dbRealm.objects(User.self)
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLoggedIn.userName)
        
//        print("the user",theUser.first?.userExpenseList ?? [])
//        print("the user count", theUser.count)
        if theUser.count >= 1{
            let sameId = theUser.first?.id
//            let expense = dbRealm.objects(NewExpense.self)
//            print("------------",expense)
            for eachExpense in theUser{
                userLoggedIn.userExpenseList.append(objectsIn: eachExpense.userExpenseList)
            }
            print("------------",userLoggedIn.userExpenseList)
//            userLoggedIn.userExpenseList.append((theUser.first?.userExpenseList.first)!)
            userLoggedIn.userExpenseList.append(newExpense)
            userLoggedIn.updateUserData(sameId!)//check if we can remve forced
            
        }else{
            let lastId = allUser.last?.id ?? 0
            userLoggedIn.userExpenseList.append(newExpense)
            userLoggedIn.saveUserData(lastId)
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
//            self?.tblViewAddItem.reloadData()
            //            self?.newExpenseTemp.removeSaveTemp()
            
        }
    }
    
    //to add expense and save
    func displayItemListTemp() {
            
            let newExpenseTemp = NewExpenseTemp()
        
            newExpenseTemp.itemNameTemp = self.itemNameTemp
        if (itemMoneyTemp.isEmpty == false){
            newExpenseTemp.moneySpentTemp = Double(self.itemMoneyTemp)!
        }else{
            print("nothing")
        }
        
        
            self.newExpenseTempList.append(newExpenseTemp)
        print("newExpenseTempList",newExpenseTempList)
            self.newExpense.addList.append(newExpenseTemp)// cause temp was overiting previous value so
//            self.anotherTempObj = newExpenseTemp
//        self.tblViewAddItem.reloadData()

            print(self.newExpenseTempList.count)

        
        

    }
    
//    func getAddingItemsViewController() -> AddingItemsViewController {
//        if addingItemsViewController == nil {
////            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
////            let addItemsVC = mainStory.instantiateViewController(withIdentifier: "addItemsVC") as! AddingItemsViewController
//            //            expenseListVC.navigationItem.backBarButtonItem = nil
////            addingItemsViewController = addItemsVC
//            
////            let storyboard : UIStoryboard = UIStoryboard(name: "THE_NAME_OF_YOUR_STORYBOARD", bundle: nil)
////            let vc = storyboard.instantiateViewController(withIdentifier: "THE_IDENTIFIER_OF_YOUR_VIEWCONTROLLER")
//            
//            
//        }
//        return addingItemsViewController!
//    }

    
    
//    func expenseFieldDidChangeTemp(textField: UITextField) {
//        
//        self.currentCreateActionTemp.isEnabled = (textField.text?.characters.count)! > 0
//    }
    
    
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


//extension NSDate {
//    static let iso8601DateFormatter: DateFormatter = {
//        let formatter = DateFormatter() //DateFormatter()
//        formatter.calendar = Calendar(identifier: .iso8601)
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.timeZone = TimeZone.current
//        formatter.dateFormat = "yyyy-MM-dd"
//        return formatter
//    }()
//    var currentDateTime: String {
//        return NSDate.iso8601DateFormatter(from: self)
//    }
//}

