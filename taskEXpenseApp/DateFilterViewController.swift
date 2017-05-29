//
//  DateFilterViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/16/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class DateFilterViewController: UIViewController {
    
    @IBOutlet weak var txtfromDate: UITextField!
    
    @IBOutlet weak var txtToDate: UITextField!
    
    @IBOutlet weak var viewUnderPicker: UIView!
    var expenseListTablevc:ExpenseListViewController?

    @IBOutlet weak var pickerDate: UIDatePicker!

    var count = 0
    
    var firstDate: NSDate?
    var secondDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerDate.isHidden = true
        viewUnderPicker.isHidden = true


        // Do any additional setup after loading the view.
    }

    @IBAction func btnSelectFromDate(_ sender: Any) {
//        print("b1")
        pickerDate.isHidden = false
        viewUnderPicker.isHidden = false
        self.pickerDate.center.y += view.bounds.height
        self.viewUnderPicker.center.y += view.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.pickerDate.center.y -= self.view.bounds.height
            self.viewUnderPicker.center.y -= self.view.bounds.height
            
            
        }, completion: {(true)->() in// ask what true or false meant
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let strDate = dateFormatter.string(from: self.pickerDate.date)
            self.txtfromDate.text = strDate
            self.firstDate = self.pickerDate.date as NSDate
//            print("from",self.pickerDate.date)
            
        })
        count = 1
    }
    
    @IBAction func btnSelectToDate(_ sender: Any) {
//        print("b2")
        pickerDate.isHidden = false
        viewUnderPicker.isHidden = false
        self.pickerDate.center.y += view.bounds.height
        self.viewUnderPicker.center.y += view.bounds.height
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.pickerDate.center.y -= self.view.bounds.height
            self.viewUnderPicker.center.y -= self.view.bounds.height

            
        }, completion: {(true)->() in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            let strDate = dateFormatter.string(from: self.pickerDate.date)
            self.txtToDate.text = strDate
            self.secondDate = self.pickerDate.date as NSDate
//            print("to",self.pickerDate.date)

        })
        
//        pickerDate.isHidden = false
//        viewUnderPicker.isHidden = false
        count = 2
    }
    
    @IBAction func pickDate(_ sender: Any) {
//        print("sender",sender)
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let strDate = dateFormatter.string(from: pickerDate.date)
        if count == 1{
            self.txtfromDate.text = strDate
            firstDate = pickerDate.date.startOfDay as NSDate
//            print("fd",firstDate!)
        }else{
            self.txtToDate.text = strDate
            secondDate = pickerDate.date.endOfDay as NSDate?
//            print("fd",secondDate!)
        }
    }
    
    @IBAction func cancelView(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func doneDatePick(_ sender: Any) {
        print("dates", firstDate!, secondDate!)
        expenseListTablevc?.expenselists = expenseListTablevc?.loadFilteredExpenseList(firstDate!, secondDate!)
        expenseListTablevc?.tblView.reloadData()
        
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
extension Date {// as varible says
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
}
