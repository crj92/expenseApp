//
//  NewExpense.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/24/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
import RealmSwift

class NewExpense: Object{
    
//    dynamic var moneySpent: Double = Double(0.0)
    
    dynamic var eventTitle: String = ""
    dynamic var totalMoneySpent: Double = Double(0.0)
    let addList = List<NewExpenseTemp>()
    dynamic var dateCreated = NSDate()
    var assignedGroup = List<PrivateGroup>()////work here#####################
    
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let url = DocumentsDirectory.appendingPathComponent("ExpenseAppDatabase.realm")//this will be used by all models
    
    
    //save to realm database
//    func save() {
//        print("got some data",addList)
//        eventTitle = tempList[0].titleTemp
//        totalMoneySpent = addAllExpense()
//        print("dir","\(NewExpense.DocumentsDirectory)")

//        do {
//            try dbRealm.write {
//                dbRealm.add(self)
//            }
//        } catch let error as NSError {
//            print("#########################")
//            fatalError(error.localizedDescription)
//        }
//    }
    
    func addAllExpense() -> Double{
        var sum: Double = 0.0
        for i in 0..<addList.count{
            sum += addList[i].moneySpentTemp
        }
        return sum
    }
    
}
