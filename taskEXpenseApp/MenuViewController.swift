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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: Any) {
        
        let swVC = getLoginViewController()
        UIView.animate(withDuration: 1, animations: {
            self.navigationController!.setViewControllers([swVC], animated: true)//(swVC, animated: true)
        }, completion: nil)
        
        self.view.endEditing(true)
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
