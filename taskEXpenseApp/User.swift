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
    let userExpenseList = List<NewExpense>()
    let groupList = List<PrivateGroup>()
    
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
        print("in write******",dbRealm.isInWriteTransaction)
    }
    
    
//    func updateUserGroupList(_ inputId: Int)->(){
//        
//            self.id = inputId
//            print("iser already der iccccc",id)
//            try! dbRealm.write {
//                //            realm.create(Book.self, value: ["id": 1, "price": 9000.0], update: true)
//                // the book's `title` property will remain unchanged.
//                dbRealm.create(User.self, value: ["id": inputId,"groupList": self.groupList!], update: true)//(User.self, value: ["id": inputId, "groupList": self.groupList!], update: true)
//                
//            }
//            
//    }
    //use later
    func deleteData1(_ inputId : Int,_ object : Object){
        self.id = inputId
        try! dbRealm.write {
            dbRealm.delete(object)
        }
    }
    
}


