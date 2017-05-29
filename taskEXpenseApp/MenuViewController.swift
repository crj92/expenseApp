//
//  MenuViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/9/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    var loginViewController: LoginViewController?
    var groupListViewController: GroupListViewController?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func groups(_ sender: Any) {
        
        let swVC = getGroupListViewController()
        UIView.animate(withDuration: 1, animations: {
            self.navigationController!.setViewControllers([swVC], animated: true) //setViewControllers([swVC], animated: true)//(swVC, animated: true)
        }, completion: nil)
        
//        self.view.endEditing(true)
        
        
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let swVC = getLoginViewController()
        UIView.animate(withDuration: 1, animations: {
            self.navigationController!.setViewControllers([swVC], animated: true)//(swVC, animated: true)
        }, completion: nil)
        
//        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)//to pop any view in nav vc
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
    
    func getGroupListViewController() -> GroupListViewController {
        if groupListViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let groupVC = mainStory.instantiateViewController(withIdentifier: "groupTableVC") as! GroupListViewController
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            groupListViewController = groupVC
            
        }
        return groupListViewController!
    }

}
