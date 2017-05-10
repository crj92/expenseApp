//
//  SigningUpViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/5/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class SigningUpViewController: UIViewController {

    @IBOutlet weak var viewVisualEffect: UIVisualEffectView!
    @IBOutlet weak var txtEmail: UITextView!
    @IBOutlet weak var txtUserName: UITextView!
    @IBOutlet weak var txtPwd: UITextView!
    @IBOutlet weak var txtConfirmPwd: UITextView!
    @IBOutlet weak var btnCreate: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //txtEmail.text = "Enter Email Id"
        //txtEmail.textColor = UIColor.lightGray
        
        //txtPwd.text = "Enter Password"
        //txtPwd.textColor = UIColor.lightGray
        
        self.viewVisualEffect.center.y += view.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.viewVisualEffect.center.y -= self.view.bounds.height
        }, completion: nil)
        
        
        
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    //func textViewDidBeginEditing(_ textView: UITextView) {
      //  if txtEmail.textColor == UIColor.lightGray {
        //    txtEmail.text = nil
          //  txtEmail.textColor = UIColor.black
        //}
        
        //if txtPwd.textColor == UIColor.lightGray {
          //  txtPwd.text = nil
            //txtPwd.textColor = UIColor.black
        //}
    //}
    //func textViewDidEndEditing(_ textView: UITextView) {
      //  if txtEmail.text.isEmpty {
        //    txtEmail.text = "Enter Email Id"
          //  txtEmail.textColor = UIColor.lightGray
        //}
        //if txtPwd.text.isEmpty {
          //  txtPwd.text = "Enter Password"
           // txtPwd.textColor = UIColor.lightGray
        //}
    //}


}
