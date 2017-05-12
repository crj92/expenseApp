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
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtUserName: UITextView!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var txtConfirmPwd: UITextField!
    @IBOutlet weak var btnCreate: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        self.viewVisualEffect.center.y += view.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.viewVisualEffect.center.y -= self.view.bounds.height
        }, completion: nil)   
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    //here give every thing to signup model class and same object be shared with seave personal infor vc den additional info and en back to whole model class
    @IBAction func createAccount(_ sender: Any) {
        newSignUpGlobal.emailId = txtEmail.text!
        newSignUpGlobal.idPwd = txtPwd.text!
    }


}
