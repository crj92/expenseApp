//
//  NewExpenseTemp.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 4/27/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
import RealmSwift

class NewExpenseTemp: Object {
    dynamic var itemNameTemp: String = ""
    dynamic var moneySpentTemp: Double = Double(0.0)
    
    //save to realm database
//    func saveTemp() {
////        print(moneySpentTemp)
//        
//        do {
//            try dbRealm.write {
//                dbRealm.add(self)
//            }
//        } catch let error as NSError {
//            print("#########################")
//            fatalError(error.localizedDescription)
//        }
//    }
//    func removeSaveTemp() {
//        //        print(moneySpentTemp)
//        
//        do {
//            try dbRealm.write {
//                dbRealm.delete(self)
//            }
//        } catch let error as NSError {
//            print("#########################")
//            fatalError(error.localizedDescription)
//        }
//    }
}
