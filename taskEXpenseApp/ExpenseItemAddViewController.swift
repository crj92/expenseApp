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
    
    @IBOutlet weak var btnAddTempItems: UIButton!
    
    
    var itemNameTemp = ""
    var itemMoneyTemp = ""
    var newExpenseTempList = List<NewExpenseTemp>()
    var newExpenseList = List<NewExpense>()//used in add items
//    var anotherTempObj: NewExpenseTemp?
    let userLoggedIn = User()
    let newExpense = NewExpense()//trying again
    
    var groupViewController: GroupListViewController?
//    var expenseListVC: ExpenseListViewController?
    var editItemViewController: AddItemsViewController?
    var selectedGroup = PrivateGroup()
    
    var context = ""
    
    var selectedExpense: NewExpense!
    var itemCellActive = [UITableViewCell]()
//    var scope = ""
    var newTempList = List<NewExpenseTemp>()



    @IBOutlet weak var btnSave: UIBarButtonItem!
    
    @IBOutlet weak var lblGroupName: UILabel!
    
    var isRowGettingDeleted = false
    var isAddItemUpdate = false// manipulated from add vc
    var isRowGettingEdited = false// manipulated here
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        tblViewAddItem.dataSource = self
        tblViewAddItem.delegate = self
        print("**********",selectedExpense)
        
        tblViewAddItem.rowHeight = UITableViewAutomaticDimension
        tblViewAddItem.estimatedRowHeight = 140
        

    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        if(context == "addNewExpense"){
            
        }else if (context == "detailExpense"){
            txtName.isUserInteractionEnabled = false// we dont wnat user to change expense list
            newTempList = selectedExpense.addList
            btnAddTempItems.isHidden = true
            btnSave.title = "Edit"
            self.navigationItem.title = "Expense Detail"//change to edit expense later
            self.txtName.text = selectedExpense.eventTitle
            if(selectedExpense.assignedGroup.first?.groupName != ""){// for expense having group , populate it
                lblGroupName.text = selectedExpense.assignedGroup.first?.groupName
//                print(btnGroupAssigned.titleLabel!)
                self.tblViewAddItem.tableFooterView = UIView()//remove extra lines under table
            }else{
                print("no group name")////
            }
            for cell in itemCellActive{
                cell.isUserInteractionEnabled = false
            }
            
        }
    }
    
    @IBAction func showGroup(_ sender: Any) {
        if(context == "addNewExpense"){
        
            let gVC = getGroupViewController()
            gVC.contextFrom = "fromExpenseItemVC"

            gVC.expenseItemAddViewController = self
            
            UIView.animate(withDuration: 1, animations: {
                self.navigationController!.pushViewController(gVC, animated: true)
            }, completion: nil)
            
//            self.view.endEditing(true)// why? dismiss keyb
            //            navigationController?.popViewController(animated: true)// to remove vc from nav set// activating this removes coming vc.. here group vc
        }else if (context == "detailExpense"){
            let getVC = getShowGroupViewController()
            getVC.contextFrom = "forEditingfromExpenseVC"
            getVC.expenseAddViewController = self
            
            UIView.animate(withDuration: 1, animations: {
                self.navigationController!.pushViewController(getVC, animated: true)//(swVC, animated: true)
            }, completion: nil)
        }

        
        
    }
    
    func getGroupViewController() -> GroupListViewController {
        if groupViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let groupVC = mainStory.instantiateViewController(withIdentifier: "groupTableVC") as! GroupListViewController
            //            self.navigationItem.leftBarButtonItem = nil
            
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            groupViewController = groupVC
            
        }
        return groupViewController!
    }
    
    func getShowGroupViewController() -> GroupListViewController {
        if groupViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let groupVC = mainStory.instantiateViewController(withIdentifier: "groupTableVC") as! GroupListViewController
//            groupVC.contextFrom = "fromExpenseItemVC"
            //            self.navigationItem.leftBarButtonItem = nil
            
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            groupViewController = groupVC
            
        }
        return groupViewController!
    }
    
    @IBAction func addItems(_ sender: Any) {
    
    }
    
    //works only when connected to outlets
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue")
        if let destination = segue.destination as? AddItemsViewController{
            destination.expenseListTablevc = self
        }
//        if let destination = segue.destination as? GroupListViewController{
//            destination.expenseItemAddViewController = self
//        }
    }



    
    @IBAction func saveData(_ sender: Any) {
        saveToDatabase(txtName.text!)
    }
    
    func saveToDatabase(_ oldExpenseTitle: String){
        //        if(context == "addNewExpense"){
        if(btnSave.title == "Save"){
            //        let newExpense = NewExpense()// global this helps to persist temp into expense
            if((context == "editedExpense") && (isAddItemUpdate == false)){//ie edit btn clicked but new row wer not aded
                displayItemListTemp("empty")//call this to retail previous temp list data

            }
            newExpense.eventTitle = txtName.text!
            //        newExpense.addList.append(anotherTempObj!)
            newExpense.totalMoneySpent = newExpense.addAllExpense()
            newExpense.dateCreated = NSDate()
            newExpense.assignedGroup.append(selectedGroup)
            
//            print(newExpense.dateCreated)
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
                for result in theUser{
//                    if(context == "addNewExpense"){
//                        userLoggedIn.groupList.append(objectsIn: result.groupList)
//                        userLoggedIn.userExpenseList.append(objectsIn: result.userExpenseList)
//                    }
//                    else if (context == "editedExpense"){
                        userLoggedIn.groupList.append(objectsIn: result.groupList)
                        for expense in result.userExpenseList{
                            if(expense.eventTitle != oldExpenseTitle){
                                userLoggedIn.userExpenseList.append(expense)
                            }else{
                                print(oldExpenseTitle,"is old and discarded")
                            }
                        }
//                        userLoggedIn.userExpenseList.append(objectsIn: result.userExpenseList)
//                    }else{
//                        print("take care of this context",context)
//                    }
                }
                //                print("------------",userLoggedIn.userExpenseList)
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
        }else if ((context == "detailExpense")){//chk this to button name
            enableEditingCell()
            
        }

    }
    
    //to add expense and save.. called in add item vc
    func displayItemListTemp(_ oldTempListName: String) {
      print("**&&&&&&",context)//fromAddItemsVC
        userLoggedIn.userName = userLoggedId

            let newExpenseTemp = NewExpenseTemp()
        
            newExpenseTemp.itemNameTemp = self.itemNameTemp
        if (itemMoneyTemp.isEmpty == false){
            newExpenseTemp.moneySpentTemp = Double(self.itemMoneyTemp)!
        }else{
            print("nothing")
        }
        
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLoggedIn.userName)
            for result in theUser{
                if(context == "editedExpense"){
                    for expense in result.userExpenseList{
                        if(expense.eventTitle == txtName.text){
                            for temp in expense.addList{
                                if(temp.itemNameTemp != oldTempListName){
                                    self.newExpenseTempList.append(temp)
                                    self.newExpense.addList.append(temp)
                                }else{
                                    print("old temp item discarded",temp.itemNameTemp)
                                }
                                
                            }
                        }
                    }
                }
                else if(context == "addNewExpense"){
                    print("later")
                    
                }
            }
       
        if(isAddItemUpdate == true){// if new row aded.. apeend those data
            
            self.newExpenseTempList.append(newExpenseTemp)//---latest
            self.newExpense.addList.append(newExpenseTemp)
        }
        
        
//            self.newExpenseTempList.append(newExpenseTemp)//---latest
//            self.newExpense.addList.append(newExpenseTemp)//-- latest// cause temp was overiting previous value so// why 2 times .. chk later

            print(self.newExpenseTempList.count)
        
    }
}

extension ExpenseItemAddViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        if((context == "addNewExpense")){
            count = newExpenseTempList.count
        }else if(context == "detailExpense"){
            count = (newTempList.count)
        }else if((context == "editedExpense")){
            if (isRowGettingDeleted == false){
                count = newExpenseTempList.count
            }else if(isRowGettingDeleted == true){
                count = (newTempList.count)
            }else{
               print("check this case isRowGettingDeleted", isRowGettingDeleted)
            }
        }
        else{
            print("chek di context and isRowGettingDeleted",context, isRowGettingDeleted)
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewAddItem.dequeueReusableCell(withIdentifier: "ItemsCell") as! NewExpenseAddItemsTableViewCell
        if ((context == "addNewExpense")){
            
            cell.txtItemsName.text = newExpenseTempList[indexPath.row].itemNameTemp
            cell.txtItemsValue.text = String(newExpenseTempList[indexPath.row].moneySpentTemp)
        }
        else if(context == "detailExpense"){
            let list = newTempList[indexPath.row]
            cell.txtItemsName.text = list.itemNameTemp
            cell.txtItemsValue.text = String(describing: list.moneySpentTemp)// why describing
            cell.isUserInteractionEnabled = false
            itemCellActive.append(cell)
        }else if((context == "editedExpense")){
            if(isRowGettingDeleted == false){
                cell.txtItemsName.text = newExpenseTempList[indexPath.row].itemNameTemp
                cell.txtItemsValue.text = String(newExpenseTempList[indexPath.row].moneySpentTemp)
            }else if(isRowGettingDeleted == true){
                let list = newTempList[indexPath.row]
                cell.txtItemsName.text = list.itemNameTemp
                cell.txtItemsValue.text = String(describing: list.moneySpentTemp)// why describing
//                cell.isUserInteractionEnabled = false// not here
                itemCellActive.append(cell)
            }else{
                print("check this")
            }
        }
//        else if(context == "editedExpense"){
        
//        }
//            else if(context == "fromAddItemsVC"){
//            let editedTempList = List<NewExpenseTemp>()
//            for eachElement in newTempList{
//                editedTempList.append(eachElement)
//            }
//            for eachElement in newExpenseTempList{
//                editedTempList.append(eachElement)
//            }
//            let list = editedTempList[indexPath.row]
//            cell.txtItemsName.text = list.itemNameTemp
//            cell.txtItemsValue.text = String(describing: list.moneySpentTemp)
//        }
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            //            let tempItemGotDeleted = self.newTempList[indexPath.row]
            self.isRowGettingDeleted = true//this will manipulate tableview which arraw to take to laod data from
            
            do{
                try dbRealm.write {
                    let tempItemGotDeleted = self.newTempList.remove(at: indexPath.row)//this deleted it from db, but i want to delete it from global model
                    print(tempItemGotDeleted, "tempItemGotDeleted")
                    self.deleteSelectedTempItem(tempItemGotDeleted.itemNameTemp)
                }
            }
            catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            //            self.navigationItem.backBarButtonItem?.isEnabled = false
            //            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.hidesBackButton = true
//            self.navigationController?//.navigationBar.isUserInteractionEnabled = false
            
//            self.navigationController?.navigationBar.tintColor = UIColor.lightGray
            tableView.reloadData()
            
        }
        
        let editing = UITableViewRowAction(style: .normal, title: "Edit") { (action, indexPath) in
            // this dailed down version to load vc.. see y prev1s were used
            let tempItemGotEdited = self.newTempList[indexPath.row]
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let addItemsEditVC = mainStory.instantiateViewController(withIdentifier: "addItemsVcId") as! AddItemsViewController
            self.isRowGettingEdited = true
            addItemsEditVC.expenseListTablevc = self
            addItemsEditVC.oldItemName = (tempItemGotEdited.itemNameTemp)
            addItemsEditVC.oldMoneySpent = String(describing: tempItemGotEdited.moneySpentTemp)
            self.present(addItemsEditVC, animated: true, completion: nil)
            
            do{
                try dbRealm.write {
                    
                    self.deleteSelectedTempItem((tempItemGotEdited.itemNameTemp))
                    
                }
            }
            catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            
            
            
            // 1-----
//            let aVC = self.getAddItemViewController()
//            
////            aVC.expenseItemAddViewController = self
//            
//            UIView.animate(withDuration: 1, animations: {
//                self.navigationController!.pushViewController(aVC, animated: true)
//            }, completion: nil)
//            
//            self.view.endEditing(true)
            //1-----
            
        }
        
        editing.backgroundColor = UIColor.blue
        
        return [delete, editing]
    }
    
//    func getAddItemViewController() -> AddItemsViewController {
//        if editItemViewController == nil {
//            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
//            let addVC = mainStory.instantiateViewController(withIdentifier: "addItemsVcId") as! AddItemsViewController
//            editItemViewController = addVC
//            
//        }
//        return editItemViewController!
//    }

    
    
    
    
    //delete item // here direct delete from model
    func deleteSelectedTempItem(_ inputItemName: String) {
        let item = dbRealm.objects(NewExpenseTemp.self).filter("itemNameTemp == %@", inputItemName)
        dbRealm.delete(item)
//        context = "detailExpense"// hera pheri 2
        //we want 2nd condition for count
    }
//
//    // user interaction enabled for user
    func enableEditingCell(){
        // removing in line editing// try later- task
        //at the time of adding, mistake happened, and want to delete.. exception hapen- task
        for eachcell in itemCellActive{
            eachcell.isUserInteractionEnabled = true
        }
//        print(itemCellActive)
        btnSave.title =  "Save"
        self.navigationItem.title = "Edit Expense"
        btnAddTempItems.isHidden = false
//        context == "addNewExpense"
//        expenseListVC?.navigationItem.leftBarButtonItem?.title = "Cancel"
        context = "editedExpense"
        
    }
}



