//
//  ViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/17/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var txtAddExpense: UITextField!
    var results = [NewExpense]()
    var expenselists : Results<NewExpense>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.dataSource = self
        tblView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        expenselists = readTasksAndUpdateUI()
        
    }
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblShowExpense: UILabel!
    
    @IBAction func add(_ sender: Any) {
        if let value = txtAddExpense.text, value != ""{
            let newExpense = NewExpense()
            newExpense.moneySpent = (NumberFormatter().number(from: value)?.doubleValue)!
            newExpense.save()
            txtAddExpense.text = ""
            expenselists = readTasksAndUpdateUI()
            self.tblView.reloadData()
        }
        }
    
    func readTasksAndUpdateUI() -> Results<NewExpense>{
        
         return   dbRealm.objects(NewExpense.self)
//        self.tblView.setEditing(false, animated: true)
        
//        print(expenselists)
//        return expenselists
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(getMoneySpentFromDatabase().count)
        print("count",expenselists.count)
        return expenselists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell")
//        cell.textLabel?.text="row#\(indexPath.row)"
//        cell.detailTextLabel?.text="subtitle#\(indexPath.row)"
        //cell.lbl
        //cell.lblShowExpense.text = "row#\(indexPath.row)"
        let list = expenselists[indexPath.row]
        print(list)
        cell?.textLabel?.text = String(list.moneySpent)
        return cell!
    }
    

}
