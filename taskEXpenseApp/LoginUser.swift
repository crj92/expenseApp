//
//  LoginUser.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/9/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
import RealmSwift

class LoginUser {
    
    dynamic var  userId: String = ""
    dynamic var  userPwd: String = ""
    
}


//class PersonAndCarRelation:Object{
//    
//    dynamic var person: Person?
//    dynamic var car: Car?
//    dynamic var contextAttribute = ""
//    
//}
//let personID = "123456789"
//let personAndCarArray = realm.objects(PersonAndCarRelation).filter("person.id == \(personID)")
//for personAndCar in personAndCarArray{
//    let personName = personAndCar.person.name
//    let carName = personAndCar.car.name
//    let context = personAndCar.contextAttribute
//    println("I am \(personName). I have a \(carName) with \(context)")
//}
