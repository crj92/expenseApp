//
//  ViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/17/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift

class ExpenseListViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var btnMenu: UIBarButtonItem!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //    var results = [NewExpense]()
    var expenselists : List<NewExpense>?
    var currentCreateAction:UIAlertAction!
    var firstTime: Bool? = true
    var selectedIndexPath:IndexPath? = nil
    let userLogged = User()
    var firstDateChosen : NSDate?
    var secondDateChosen : NSDate?
    // declare as property
    //    var searchBar: UISearchBar!//custom search bar
    
    
    //testing if button pass will satisfy tap not canceled on it...in login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() ///-----1
        searchBar.delegate = self
        
        userLogged.userName = userLoggedId
        
        
        
        
        
        //reveal
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        
        
        
        
        
        
    }
    
    //    @IBAction func searchExpense(_ sender: Any) {
    //
    //        // in action to show // search bar expands
    //        searchBar.frame = CGRect(x: 0.0, y : 0, width : 320,height :  44)
    //    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
            //            self?.tblView.reloadData()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        // in viewWillDisappear// search bar goes off
        //        searchBar.removeFromSuperview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        expenselists = readTasksAndUpdateUI(firstDateChosen,secondDateChosen)
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 140
        navigationItem.backBarButtonItem?.tintColor = UIColor.green
        print("dir","\(NewExpense.DocumentsDirectory)")
        expenselists = loadAllExpenseList()
        self.tblView.tableFooterView = UIView()//remove extra lines under table
        self.tblView.reloadData()
        //hide back button here
        navigationItem.hidesBackButton = true
        print("------hey------",userLogged.userExpenseList)
        
        
        
    }
    
    @IBAction func filterExpense(_ sender: Any) {
        //        expenselists = readTasksAndUpdateUI(NSDate(),NSDate())
    }
    
    @IBAction func clearFilterResult(_ sender: Any) {
        expenselists = loadAllExpenseList()
        self.tblView.reloadData()
        
        
    }
    
    func loadAllExpenseList() -> List<NewExpense>{
        if expenselists?.count != 0{
            expenselists?.removeAll()
        }
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLogged.userName)//.first?.userExpenseList.filter("dateCreated == 2017-05-15 16:29:12 +0000")
        //        if(firstDate.compare(NSDate(). as Date) == .orderedSame){
        for eachExpense in theUser{
            userLogged.userExpenseList.append(objectsIn: eachExpense.userExpenseList)
        }
        return   userLogged.userExpenseList
        
    }
    
    func loadFilteredExpenseList(_ firstDate: NSDate, _ secondDate: NSDate) -> List<NewExpense>{
        if expenselists?.count != 0{
            expenselists?.removeAll()
        }
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLogged.userName)
        let nsPredicateForDate = NSPredicate(format: "dateCreated BETWEEN %@", [firstDate, secondDate])//NSPredicate(format: "dateCreated < %@", NSDate())
        
        let nsPredicateTRY = NSPredicate(format: "dateCreated > %@ AND dateCreated < %@", firstDate, secondDate)
//        tanDogs = realm.objects(Dog.self).filter(predicate)
        
        for expenselist in theUser{
            for eachExpense in expenselist.userExpenseList.filter(nsPredicateForDate)//("dateCreated == \(Date())")
            {
                self.expenselists?.append(eachExpense)//why 1##############
            }
            //            userLogged.userExpenseList.append(objectsIn: eachExpense.userExpenseList)
        }
        
        print("------hey------",userLogged.userExpenseList)
        return   userLogged.userExpenseList//why 2 #############
        //        self.tblView.setEditing(false, animated: true)
    }
    
    func loadFilteredBySearchExpenseList(_ title: String) -> List<NewExpense>{
        if expenselists?.count != 0{
            expenselists?.removeAll()
        }
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLogged.userName)
        let nsPredicateForTitle = NSPredicate(format: "eventTitle == %@", title)//NSPredicate(format: "dateCreated < %@", NSDate())
        for expenselist in theUser{
            for eachExpense in expenselist.userExpenseList.filter(nsPredicateForTitle)//("dateCreated == \(Date())")
            {
                self.expenselists?.append(eachExpense)//why 1##############
            }
            //            userLogged.userExpenseList.append(objectsIn: eachExpense.userExpenseList)
        }
        
//        print("------hey------",userLogged.userExpenseList)
        return   userLogged.userExpenseList//why 2 #############
        //        self.tblView.setEditing(false, animated: true)
    }
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExpenseItemAddViewController{            
            if(segue.identifier == "fromAddButton"){
                destination.context = "addNewExpense"
            }else if(segue.identifier == "fromCell"){
                let indexPath = tblView.indexPathForSelectedRow
                destination.context = "detailExpense"
//                destination.txtName.isUserInteractionEnabled = false// we dont want user to edit expene name
//                destination.scope = "fromExpenseList"
//                destination.expenseListVC = self

                destination.selectedExpense = expenselists?[(indexPath?.row)!]

            }
        }
        
        if let destination = segue.destination as? ExpenseDetailViewController ,
            let indexPath = tblView.indexPathForSelectedRow {
            destination.selectedExpense = expenselists![indexPath.row]
            destination.scope = "fromExpenseList"
        }
        if let destination = segue.destination as? DateFilterViewController{
            destination.expenseListTablevc = self
        }
    }
}

extension ExpenseListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count",expenselists!.count)
        return expenselists!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell") as! NewExpenseTableViewCell
        let list = expenselists![indexPath.row]
        cell.lblDateCreated.text = convertDateFormater(list.dateCreated)
        cell.lblTitle.text = list.eventTitle
        cell.lblTotalMoneySpent.text = String(list.totalMoneySpent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           let  expenseGotDeleted = expenselists?.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
            deleteSelectedExpense((expenseGotDeleted?.eventTitle)!)
            tableView.reloadData()


        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    //delete group
    func deleteSelectedExpense(_ inputExpenseName: String) {
        let theUserResult = dbRealm.objects(User.self).filter("userName == %@", userLogged.userName)
        for theUser in theUserResult{
            
            for eachExpense in theUser.userExpenseList//("dateCreated == \(Date())")
            {
                if(eachExpense.eventTitle == inputExpenseName){
                    do{
                        try dbRealm.write {
                            print("this EXPENSE is gone",eachExpense.eventTitle)
                            dbRealm.delete(eachExpense)
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


    
    
    //ns date to short date
    func convertDateFormater(_ date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        dateFormatter.dateFormat = "dd/MM"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let timeStamp = dateFormatter.string(from: date as Date)
        
        return timeStamp
    }
}
// note here i have changed     var expenselists : List<NewExpense>! to     var expenselists : List<NewExpense>? beacause to chk if already expense list has some value remove it while calling readTasksAndUpdateUI(), it was duplicating already present data in expenselist table.

extension ExpenseListViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //work on dynamic searching
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        expenselists = loadFilteredBySearchExpenseList(searchBar.text!)
        
        if(expenselists?.isEmpty == true){
            print("expense not found")
            expenselists = loadAllExpenseList()
            let alert = UIAlertController(title: "Expense not Found", message: "Try again", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "Okay",
                                          style: UIAlertActionStyle.default,
                                          handler: {(alert: UIAlertAction!) in print("Foo")
                                            self.expenselists = self.loadAllExpenseList()
                                            self.tblView.reloadData()}))
            
            
            self.present(alert, animated: true, completion: nil)
            
        }else{
            self.tblView.reloadData()
        }
        
    }
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        print("blah")
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        print("blah blah")
    }
}



