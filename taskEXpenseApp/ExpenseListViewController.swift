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
    
    
//    var results = [NewExpense]()
    var expenselists : List<NewExpense>?
    var currentCreateAction:UIAlertAction!
    var firstTime: Bool? = true
    var selectedIndexPath:IndexPath? = nil
    let userLogged = User()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        //reveal
        if self.revealViewController() != nil {
            btnMenu.target = self.revealViewController()
            btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tblView.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        userLogged.userName = userLoggedId
        expenselists = readTasksAndUpdateUI("", "")
        tblView.dataSource = self
        tblView.delegate = self
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 140
        navigationItem.backBarButtonItem?.tintColor = UIColor.green
        print("dir","\(NewExpense.DocumentsDirectory)")
        self.tblView.reloadData()
        //hide back button here
        navigationItem.hidesBackButton = true

    }
    
    @IBAction func filterExpense(_ sender: Any) {
        expenselists = readTasksAndUpdateUI("2017-05-15","2017-05-18")
    }
    
    @IBAction func clearFilterResult(_ sender: Any) {
        expenselists = readTasksAndUpdateUI("","")

    }
    
    func readTasksAndUpdateUI(_ firstDate: String, _ secondDate: String) -> List<NewExpense>{
        if expenselists?.count != 0{
            expenselists?.removeAll()
        }
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userLogged.userName)
        if(firstDate == "" || secondDate == ""){
            for eachExpense in theUser{
                userLogged.userExpenseList.append(objectsIn: eachExpense.userExpenseList)
            }
        }else{
            let theFilteredUserExpense = userLogged.userExpenseList.filter("dateCreated BETWEEN %@",[firstDate, secondDate] )
            for eachExpense in theFilteredUserExpense{
                userLogged.userExpenseList.append(eachExpense)
            }
        }
        
        print("------hey------",userLogged.userExpenseList)
        return   userLogged.userExpenseList
        //        self.tblView.setEditing(false, animated: true)
    }
    //segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExpenseDetailViewController ,
            let indexPath = tblView.indexPathForSelectedRow {
            destination.selectedExpense = expenselists![indexPath.row]
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
//        print("this is list",list)
//        cell?.textLabel?.text = String(list.moneySpent)
        
//        if firstTime!  {
//            cell.accessoryType = .checkmark
//            //            cell.accessoryType = UITableViewCellAccessoryCheckmark
//        }
//        cell.textLabel?.text = String(describing: list.tempList)
        cell.lblTitle.text = list.eventTitle
        cell.lblTotalMoneySpent.text = String(list.totalMoneySpent)
        
//        cell.selectionStyle = .none
//        if let _ = selectedIndexPath {
//            if (indexPath.compare(selectedIndexPath!) == .orderedSame) {
//                if cell.accessoryType == .checkmark {
//                    cell.accessoryType = .none
//                } else {
//                    cell.accessoryType = .checkmark
//                }
//            }
//        }
        
        return cell
    }
}
// note here i have changed     var expenselists : List<NewExpense>! to     var expenselists : List<NewExpense>? beacause to chk if already expense list has some value remove it while calling readTasksAndUpdateUI(), it was duplicating already present data in expenselist table.

