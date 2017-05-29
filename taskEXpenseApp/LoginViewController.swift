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
    @IBOutlet weak var txtUserId: UITextField!
    @IBOutlet weak var txtUserPwd: UITextField!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    
    var currentCreateActionTemp : UIAlertAction!
    var count = 0
    
    
//    var expenseListViewController: ExpenseListViewController?
    var swViewController: SWRevealViewController?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dir","\(NewExpense.DocumentsDirectory)")

        
//        self.hideKeyboardWhenTappedAround()

        //push textfields' view up keybord comes
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //    for pushing views up when keyboard comes
    func keyboardWillShow(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.effectSmallWindow.center.y == self.view.center.y{//.frame.origin.y == 175{
                self.effectSmallWindow.frame.origin.y -= keyboardSize.height/2
            }
        }
    }
    
    //    for pushing views up when keyboard comes
    func keyboardWillHide(sender: NSNotification) {
        if let keyboardSize = (sender.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.effectSmallWindow.frame.origin.y != 175{//remove hardcoded
            if self.effectSmallWindow.center.y != self.view.center.y{//remove hardcoded
                self.effectSmallWindow.frame.origin.y += keyboardSize.height/2
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    @IBAction func signUpButton(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func signInButton(_ sender: Any) {
        
        
        //later aplly animation to remove and login progress
        //        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
        //            self.effectSmallWindow.center.y -= self.view.bounds.height
        //        }, completion: nil)
        
        
        //changed to overall content view
//        let expenseListVC = getExpenseListViewController()
//        UIView.animate(withDuration: 1, animations: {
//            self.navigationController!.pushViewController(expenseListVC, animated: true)
//        }, completion: nil)
        userLoggedId = txtUserId.text!

        
        if isUserAvailable(){
            let swVC = getSWViewController()
            UIView.animate(withDuration: 1, animations: {
                self.navigationController!.setViewControllers([swVC], animated: true)//(swVC, animated: true)
            }, completion: nil)
            self.view.endEditing(true)//dismiss key board y? needed.. chk if it works on one click with self.hide key board
            
        }else if (count == 1){
            let alert = UIAlertController(title: "User not Found", message: "New User? Please Sign Up", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }else if (count == 3){
            let alert = UIAlertController(title: "Incorrect User Id or Password", message: "Please enter correct Username or Password", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
        
    }
    
    func isUserAvailable() -> Bool{
        let userTryingToLogin = dbRealm.objects(NewSignUp.self).filter("emailId == %@", userLoggedId)
        print("userLoggedName validate",userLoggedId)
        //            userLoggedIn.userExpenseList.append((theUser.first?.userExpenseList.first)!)
        var isUserId = ""
        var isUserPasswordMatch = ""

        isUserId = userTryingToLogin.first?.emailId ?? ""
        isUserPasswordMatch = userTryingToLogin.first?.idPwd ?? ""
        
        print("isUserNameAvailable",isUserId)
        
        if isUserId == ""{
            count = 1
            return false
        }
        else if ((isUserId != "") && (isUserPasswordMatch == txtUserPwd.text!)) {
            count = 2
            return true
        }else{
            count = 3
            return false
        }
    }
    

    
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
           tap.cancelsTouchesInView = false//for directly touch buton and perform action, this shud be true, so if condition might make it happen
        
                //when this was false.. assoonas we neede to tap anywhere to dismiss key board .. it didnt happen whne we clicked sigin .. it only dismissed key board not sign in @ same time, but when its true its happening.
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
