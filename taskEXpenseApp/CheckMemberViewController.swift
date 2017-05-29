//
//  CheckMemberViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/17/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class CheckMemberViewController: UIViewController {
    @IBOutlet weak var txtChkThisMailId: UITextField!
    
    var createGroupVC : CreateGroupViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addThisUser(_ sender: Any) {
        if !isRegisteredUser(){
            let alert = UIAlertController(title: "User not Found", message: "Please enter Valid EmailID", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelThisView(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)//noneed chk evrywhere
        
        self.dismiss(animated: true, completion: nil)
    }

    
    func isRegisteredUser() -> Bool{
        let theUserResult = dbRealm.objects(User.self).filter("userName == %@",txtChkThisMailId.text!)
        
        if (theUserResult.isEmpty == false){
            createGroupVC?.userTemp = theUserResult.first!
            createGroupVC?.displayUserListTemp()
            createGroupVC?.tblAddedUserList.reloadData()
            return true
        }else{
            return false
        }   
    }

}
