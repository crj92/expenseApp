//
//  User.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/10/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object{
    dynamic var id = 0
    dynamic var userName: String = ""
    var expenseList = List<NewExpense>()
    
    override static func primaryKey() -> String? {
        return "id"
    }


    
    func saveUserData(_ inputId: Int) {
        id += inputId
        id += 1
        print("creating new user iddddd",id)
        do {
            try dbRealm.write {
                dbRealm.add(self)
            }
        } catch let error as NSError {
            print("#########################")
            fatalError(error.localizedDescription)
        }
    }
    func updateUserData(_ inputId: Int) {
        do {
            self.id = inputId
            print("iser already der iccccc",id)

//            let realm = try! Realm()
//            let theUser = dbRealm.objects(User.self).filter("userName == yo").first
//            try! dbRealm.write {
//                theUser.
//            }
            try dbRealm.write {
                dbRealm.add(self, update: true)
            }
        } catch let error as NSError {
            print("#########################")
            fatalError(error.localizedDescription)
        }
    }
    
}
