//
//  PrivateGroup.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/17/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import Foundation
import RealmSwift

class PrivateGroup: Object {
    dynamic var groupName = ""
    var userIncludedList = List<PrivateGroupTemp>()
}
