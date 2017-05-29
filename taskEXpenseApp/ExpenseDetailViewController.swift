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
    
    var scope = ""
    
    @IBOutlet weak var btnEdit: UIBarButtonItem!
    
    @IBOutlet weak var tblExpenseDetailView: UITableView!
    
    @IBOutlet weak var btnGroupAssigned: UIButton!
    
    var groupViewController: GroupListViewController?
    
    
    var newTempList = List<NewExpenseTemp>()
    
//    var userIsLogged = User()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tblExpenseDetailView.isUserInteractionEnabled = false

//        userIsLogged.userName = userLoggedId
        tblExpenseDetailView.dataSource = self
        tblExpenseDetailView.delegate = self
        btnEdit.title =  "Edit"
        self.navigationItem.title = selectedExpense.eventTitle
        if(selectedExpense.assignedGroup.first?.groupName != ""){
            
            btnGroupAssigned.setTitle(selectedExpense.assignedGroup.first?.groupName,for: .normal)
            print(btnGroupAssigned.titleLabel!)
        }else{
            print("no group name")////
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tblExpenseDetailView.tableFooterView = UIView()//remove extra lines under table
        newTempList = selectedExpense.addList
    }

    @IBAction func editExpenseItem(_ sender: Any) {
//        tblExpenseDetailView.isUserInteractionEnabled = true
        if (btnEdit.title ==  "Edit"){
            enableEditingCell()
        }else{
//            saveEditedItemData()
        }
    }
    @IBAction func showSelectedGroup(_ sender: Any) {
        let getVC = getShowGroupViewController()
        getVC.contextFrom = "fromExpenseDetailVC"
//        getVC.expenseDetailAddViewController = self
        
        UIView.animate(withDuration: 1, animations: {
            self.navigationController!.pushViewController(getVC, animated: true)//(swVC, animated: true)
        }, completion: nil)
        
    }
    
    func getShowGroupViewController() -> GroupListViewController {
        if groupViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let groupVC = mainStory.instantiateViewController(withIdentifier: "groupTableVC") as! GroupListViewController
            groupVC.contextFrom = "fromExpenseItemVC"
            //            self.navigationItem.leftBarButtonItem = nil
            
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            groupViewController = groupVC
            
        }
        return groupViewController!
    }
    
    func saveEditedItemData() -> (){
        //later do this
        
    }
}


extension ExpenseDetailViewController: UITableViewDataSource{
//    var cell : UITableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newTempList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblExpenseDetailView.dequeueReusableCell(withIdentifier: "tempItemCell") as! ExpenseDetailTableViewCell
        let list = newTempList[indexPath.row]
        cell.itemName.text = list.itemNameTemp
        cell.itemValue.text = String(describing: list.moneySpentTemp)// why describing
        cell.isUserInteractionEnabled = false
        itemCellActive.append(cell)
        return cell
    }
    
    //when slide be called
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        
        if(scope == "fromExpenseList"){
            return .delete
        }else{
            return .none
        }
        
    }
    
    //delete slide
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let tempItemGotDeleted = newTempList[indexPath.row]
        print("some",tempItemGotDeleted)
        if editingStyle == .delete {
            do{
                try dbRealm.write {
                    newTempList.remove(objectAtIndex: indexPath.row)//this deleted it from db, but i want to delete it from global model
                    deleteSelectedTempItem(tempItemGotDeleted.itemNameTemp)

                }
            }
            catch let error as NSError {
                fatalError(error.localizedDescription)
            }
            
            tableView.reloadData()
         }
         else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
    //delete item // here direct delete from model
    func deleteSelectedTempItem(_ inputItemName: String) {
        let item = dbRealm.objects(NewExpenseTemp.self).filter("itemNameTemp == %@", inputItemName)
            dbRealm.delete(item)
    }
    
    // user interaction enabled for user
    func enableEditingCell(){
        for eachcell in itemCellActive{
            eachcell.isUserInteractionEnabled = true
        }
        print(itemCellActive)
        btnEdit.title =  "Save"
        
    }
    
}

