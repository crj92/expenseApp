//
//  UserDetailViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/9/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    var loginViewController: LoginViewController?
    var signUpVC: SigningUpViewController?
    var newSignUp = NewSignUp()
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func saveprofile(_ sender: Any) {
        newSignUp.emailId = (signUpVC?.emailId)!
        newSignUp.idPwd = (signUpVC?.idPwd)!
        newSignUp.fullName = txtFullName.text!
        newSignUp.phoneNumber = Int(txtPhoneNumber.text!)!
        newSignUp.saveNewSignUpData()
        
        let swVC = getLoginViewController()
        UIView.animate(withDuration: 1, animations: {
            self.navigationController!.setViewControllers([swVC], animated: true)//(swVC, animated: true)
        }, completion: nil)
        
//        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)// to remove vc from nav set

    }
    

    
    //we get loginvc
    func getLoginViewController() -> LoginViewController {
        if loginViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = mainStory.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            loginViewController = loginVC
            
        }
        return loginViewController!
    }


}
