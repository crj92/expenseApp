//
//  NewSignUp.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/9/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
import RealmSwift

class NewSignUp: Object {
    dynamic var  emailId: String = ""
    dynamic var  idPwd: String = ""
    dynamic var  fullName: String = ""
    dynamic var  phoneNumber: Int = 0
    
    //save to realm database
        func saveNewSignUpData() {
            do {
                try dbRealm.write {
                    dbRealm.add(self)
                }
            } catch let error as NSError {
                print("#########################")
                fatalError(error.localizedDescription)
            }
        }
}
