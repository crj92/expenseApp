//
//  CreateGroupViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/17/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit
import RealmSwift

class CreateGroupViewController: UIViewController {
    
    //    var choosenUser = User()//no need
    //    var newChoosenUserTempList = List<User>()
    var userAlreadyLoggedIn = User()// for user login and update same user
    var privateGroup = PrivateGroup()
    var privateGroupList = List<PrivateGroup>()
    var privateGroupTempList = List<PrivateGroupTemp>()
    var userTemp = User()// this entity to be saved
    
    let noUseButton = UIButton() //--1// beacuse some thing i need to pass der.. so a dummy button
    
    @IBOutlet weak var txtGroupName: UITextField!
    
    @IBOutlet weak var tblAddedUserList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() //--1
        
        tblAddedUserList.dataSource = self
        tblAddedUserList.delegate = self
        tblAddedUserList.rowHeight = UITableViewAutomaticDimension
        tblAddedUserList.estimatedRowHeight = 140
        self.tblAddedUserList.tableFooterView = UIView()//remove extra lines under table
    }
    
    @IBAction func cancelThisView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveTheseUsersAsGroup(_ sender: Any) {
        privateGroup.groupName = txtGroupName.text!
        //        privateGroup.userIncludedList = self.newChoosenUserTempList
        //chk if user is already der then update or create a new one
        userAlreadyLoggedIn.userName = userLoggedId
        
        let allUser = dbRealm.objects(User.self)//for new user
        let theUser = dbRealm.objects(User.self).filter("userName == %@", userAlreadyLoggedIn.userName)
        if theUser.count >= 1{
            let sameId = theUser.first?.id
            //copy old records first
            for userResults in theUser{
                userAlreadyLoggedIn.userExpenseList.append(objectsIn: userResults.userExpenseList)
                userAlreadyLoggedIn.groupList.append(objectsIn: userResults.groupList)
            }
            userAlreadyLoggedIn.groupList.append(privateGroup)
            userAlreadyLoggedIn.updateUserData(sameId!)//updateUserData(sameId!)//check if we can remve forced
            
        }else{
            let lastId = allUser.last?.id ?? 0
            userAlreadyLoggedIn.groupList.append(privateGroup)
            userAlreadyLoggedIn.saveUserData(lastId)
        }
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        
        
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CheckMemberViewController{
            destination.createGroupVC = self
        }
    }
    
    //    //to add expense and save
    func displayUserListTemp() {//............. chk dis method where ever its used
        
        let privateGroupTempUser = PrivateGroupTemp()
        
        privateGroupTempUser.tempUser = self.userTemp
        self.privateGroupTempList.append(privateGroupTempUser)
        print("privateGroupTempList",privateGroupTempList)
        self.privateGroup.userIncludedList.append(privateGroupTempUser)
        print(self.privateGroupTempList.count)
    }
    

    
    
}

extension CreateGroupViewController: UITableViewDelegate ,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        print("count",groupList!.count)
        return privateGroupTempList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblAddedUserList.dequeueReusableCell(withIdentifier: "cgpListCell") as! CreateGroupTableViewCell
        let memberList = privateGroupTempList[indexPath.row]
        print(memberList.tempUser?.userName ?? "")
        cell.lblAddedUser.text = memberList.tempUser?.userName ?? ""// here some changes from is original src
        return cell
    }
}
