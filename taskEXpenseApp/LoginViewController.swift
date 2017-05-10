//
//  LoginViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/5/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var effectSmallWindow: UIVisualEffectView!
    @IBOutlet weak var txtUserId: UITextView!
    @IBOutlet weak var txtUserPwd: UITextView!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    
//    var expenseListViewController: ExpenseListViewController?
    var swViewController: SWRevealViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        //push textfields up keybord comes
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //    for pushing views up when keyboard comes
    func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.effectSmallWindow.frame.origin.y == 175{
                self.effectSmallWindow.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    //    for pushing views up when keyboard comes
    func keyboardWillHide(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.effectSmallWindow.frame.origin.y != 175{//remove hardcoded
                self.effectSmallWindow.frame.origin.y += keyboardSize.height/2
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtUserId.text = "Enter Email"
        txtUserId.textColor = UIColor.lightGray
        
        txtUserPwd.text = "Enter Password"
        txtUserPwd.textColor = UIColor.lightGray
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.effectSmallWindow.center.x += view.bounds.width
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.effectSmallWindow.center.x -= self.view.bounds.width
        }, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //unhide for other
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        
        //later aplly animation to remove and login progress
        //        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
        //            self.effectSmallWindow.center.y -= self.view.bounds.height
        //        }, completion: nil)
        
        
        //changed to menu
//        let expenseListVC = getExpenseListViewController()
//        UIView.animate(withDuration: 1, animations: {
//            self.navigationController!.pushViewController(expenseListVC, animated: true)
//        }, completion: nil)
        
        let swVC = getSWViewController()
        UIView.animate(withDuration: 1, animations: {
            self.navigationController!.setViewControllers([swVC], animated: true)//(swVC, animated: true)
        }, completion: nil)
        
        userLoggedName = txtUserId.text
        
        self.view.endEditing(true)
        
        
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if txtUserId.textColor == UIColor.lightGray {
            txtUserId.text = nil
            txtUserId.textColor = UIColor.black
            
        }
        if txtUserPwd.textColor == UIColor.lightGray {
            txtUserPwd.text = nil
            txtUserPwd.textColor = UIColor.black
            
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        self.disablesAutomaticKeyboardDismissal = true
        if txtUserId.text.isEmpty {
            txtUserId.text = "Enter Email"
            txtUserId.textColor = UIColor.lightGray
        }
        if txtUserPwd.text.isEmpty {
            txtUserPwd.text = "Enter Password"
            txtUserPwd.textColor = UIColor.lightGray
        }
    }
     // here was getting expenselist vc, but commented to get menu cause we want slide view towork with menu button
//    func getExpenseListViewController() -> ExpenseListViewController {
//        if expenseListViewController == nil {
//            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
//            let expenseListVC = mainStory.instantiateViewController(withIdentifier: "expenseListVC") as! ExpenseListViewController
////            expenseListVC.navigationItem.backBarButtonItem = nil
//            expenseListViewController = expenseListVC
//            
//        }
//        return expenseListViewController!
//    }
    
    //we get menuvc
    func getSWViewController() -> SWRevealViewController {
        if swViewController == nil {
            let  mainStory = UIStoryboard(name: "Main", bundle: nil)
            let swVC = mainStory.instantiateViewController(withIdentifier: "swVC") as! SWRevealViewController
            //            expenseListVC.navigationItem.backBarButtonItem = nil
            swViewController = swVC
            
        }
        return swViewController!
    }
    
}
// for removing keynoard when tapped arround
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = true//when this was false.. assoonas we neede to tap anywhere to dismiss key board .. it didnt happen whne we clicked sigin .. it only dismissed key board not sign in @ same time, but when its true its happening.
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
