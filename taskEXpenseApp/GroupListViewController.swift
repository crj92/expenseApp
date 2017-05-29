//
//  GroupListViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/17/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift

class GroupListViewController: UIViewController {
    
    @IBOutlet weak var btnMenuInGroup: UIBarButtonItem!
    var containsGrouplist : List<PrivateGroup>?//()// b4 here it was ? but count gives error if now vals.. so use this
    let userHasLogged = User()
    var contextFrom = ""
    var firstTimeHere: Bool? = true
    var selectedIndexPath:IndexPath? = nil
    var groupDetailViewController: GroupDetailViewController?
    var expenseItemAddViewController: ExpenseItemAddViewController?
    var expenseAddViewController: ExpenseItemAddViewController?
    //    var selectedGroup: PrivateGroup?
    
    @IBOutlet weak var tblGroupListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userHasLogged.userName = userLoggedId
        //reveal
        // use enum.....
        if contextFrom == "fromExpenseItemVC"{
            self.navigationItem.leftBarButtonItem = nil
            
        }else if(contextFrom == "forEditingfromExpenseVC"){
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = nil
            
            
        }else{
            if self.revealViewController() != nil {
                btnMenuInGroup.target = self.revealViewController()
                btnMenuInGroup.action = #selector(SWRevealViewController.revealToggle(_:))
                self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            }
        }
        
        
        
        
        tblGroupListView.dataSource = self
        tblGroupListView.delegate = self
        tblGroupListView.rowHeight = UITableViewAutomaticDimension
        tblGroupListView.estimatedRowHeight = 140
        containsGrouplist = loadUserGroupList()//try removing here
        self.tblGroupListView.tableFooterView = UIView()//remove extra lines under table
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        containsGrouplist = loadUserGroupList()
        self.tblGroupListView.tableFooterView = UIView()//remove extra lines under table
        self.tblGroupListView.reloadData()
    }
    override func viewWillDisappear(_ animated: Bool) {
        firstTimeHere = true
        print("viewWillDisappear Discover")
    }
    
    func loadUserGroupList() -> List<PrivateGroup>{
        if containsGrouplist?.count != 0{
            containsGrouplist?.removeAll()
        }
        let theUserResult = dbRealm.objects(User.self).filter("userName == %@", userHasLogged.userName)
        
        for theUser in theUserResult{
            userHasLogged.groupList.append(objectsIn: theUser.groupList)//use dis or below
            //            for eachGroup in theUser.groupList//("dateCreated == \(Date())")
            //            {
            //                userHasLogged.groupList.append(eachGroup)
            //
            //            }
        }
        return   userHasLogged.groupList//why 4
    }
    
    func deleteGroup(_ groupName: String) -> List<PrivateGroup>{
        if containsGrouplist?.count != 0{
            containsGrouplist?.removeAll()
        }
        let theUserResult = dbRealm.objects(User.self).filter("userName == %@", userHasLogged.userName)
        
        let sameId = theUserResult.first?.id
        for theUser in theUserResult{
            userHasLogged.userExpenseList.append(objectsIn: theUser.userExpenseList)
            
            
            for eachGroup in theUser.groupList//("dateCreated == \(Date())")
            {
                if(eachGroup.groupName != groupName){//does not append that group
                    userHasLogged.groupList.append(eachGroup)
                }
                else{
                    print("this group is gone",eachGroup.groupName)
                }
            }
        }
        
        userHasLogged.updateUserData(sameId!)
        
        
        return   userHasLogged.groupList//why 4
        //        note that this is deleting group from that specific user but not from universal group model, no prob for now
    }
    
}
extension GroupListViewController: UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print("count",groupList!.count)
        return containsGrouplist!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblGroupListView.dequeueReusableCell(withIdentifier: "gpListCell") as! GroupListTableViewCell
        let groupList = containsGrouplist![indexPath.row]
        print(groupList.groupName)
        if firstTimeHere!  {
            cell.accessoryType = .none//.checkmark
        }
        cell.lblGroupName.text = groupList.groupName //as? String // read abt gerting valuse directly from dict and saving it to local var ...
        
        cell.selectionStyle = .none
        if contextFrom == "fromExpenseItemVC"{// cause only required in expenselist show gourp
            if let _ = selectedIndexPath {
                if (indexPath.compare(selectedIndexPath!) == .orderedSame) {
                    if cell.accessoryType == .none {
                        cell.accessoryType = .checkmark
                    } else {
                        cell.accessoryType = .none
                    }
                }
            }
        }else if(contextFrom == "forEditingfromExpenseVC"){
            if(cell.lblGroupName.text == expenseAddViewController?.lblGroupName.text){//btnGroupAssigned.titleLabel?.text){
                cell.accessoryType = .checkmark
            }// for edit this also we can put
            
        }
        
        return cell
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let destination = segue.destination as? ExpenseDetailViewController ,
    //            let indexPath = tblView.indexPathForSelectedRow {
    //            destination.selectedExpense = expenselists![indexPath.row]
    //        }
    //        if let destination = segue.destination as? DateFilterViewController{
    //            destination.expenseListTablevc = self
    //        }
    //    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if contextFrom == "fromExpenseItemVC"{
            self.selectedIndexPath = indexPath
            firstTimeHere = false
            tableView.reloadData()
            expenseItemAddViewController?.selectedGroup = containsGrouplist![indexPath.row]
            //getSelectedDevice(indexpath: indexPath.row)//will need later
            //            print(expenseItemAddViewController?.selectedGroup)
            
            
        }else if(contextFrom == ""){//#####
            let gdVC = getGroupDetailViewController()
            //pass detail from here to detail view
            gdVC.selectedGroupShowMember = containsGrouplist![indexPath.row]
            UIView.animate(withDuration: 1, animations: {
                self.navigationController!.pushViewController(gdVC, animated: true)//(swVC, animated: true)
            }, completion: nil)
            
        }else{
            print("")
            //use it here if needed
            //            self.selectedIndexPath = indexPath
            //            firstTimeHere = false
            //            tableView.reloadData()
            //            expenseItemAddViewController?.selectedGroup = containsGrouplist![indexPath.row]
            
        }
        
    }
    
    //when slide be called
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle{
        
        if(contextFrom == ""){
            return .delete
        }else{
            return .none
        }
        
    }
    
    //delete slide
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
//        if(contextFrom == ""){
            var groupGotDeleted: PrivateGroup?
            if editingStyle == .delete {
                groupGotDeleted = containsGrouplist?.remove(at: indexPath.row)
                deleteSelectedGroup((groupGotDeleted?.groupName)!)
                
                
                tableView.reloadData()
                
                
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
            }
            
//        }else{
//            print("slide wont work here")
//        }

    }
    
    
    //delete group
    func deleteSelectedGroup(_ inputGroupName: String) {
        let theUserResult = dbRealm.objects(User.self).filter("userName == %@", userHasLogged.userName)
        for theUser in theUserResult{
            
            for eachGroup in theUser.groupList//("dateCreated == \(Date())")
            {
                if(eachGroup.groupName == inputGroupName){
                    do{
                        try dbRealm.write {
                            print("this group is gone",eachGroup.groupName)
                            dbRealm.delete(eachGroup)
                        }
                    }
                    catch let error as NSError {
                        print("#########################")
                        fatalError(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    //get vc
    func getGroupDetailViewController() -> GroupDetailViewController {
        if groupDetailViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let groupDVC = mainStory.instantiateViewController(withIdentifier: "groupDetailVC") as! GroupDetailViewController
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            groupDetailViewController = groupDVC
            
        }
        return groupDetailViewController!
    }
}
