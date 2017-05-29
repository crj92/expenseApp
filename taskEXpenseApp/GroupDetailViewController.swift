//
//  GroupDetailViewController.swift
//  taskEXpenseApp
//
//  Created by Raj Shekhar on 5/19/17.
//  Copyright © 2017 Raj Shekhar. All rights reserved.
//

import UIKit

class GroupDetailViewController: UIViewController {
    var selectedGroupShowMember: PrivateGroup!
    @IBOutlet weak var tblContainsMember: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblContainsMember.dataSource = self
        tblContainsMember.delegate = self
//        self.navigationController?.title = "Group Members"
        self.navigationItem.title = "Group Members"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: nil, action: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tblContainsMember.tableFooterView = UIView()
    }
    
}
//add table methods get dtataa and sve it to label
extension GroupDetailViewController: UITableViewDataSource, UITableViewDelegate{
    //    var cell : UITableViewCell!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedGroupShowMember.userIncludedList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblContainsMember.dequeueReusableCell(withIdentifier: "tempUserCell") as! GroupDetailTableViewCell
        let list = selectedGroupShowMember.userIncludedList[indexPath.row]
        cell.lblMemberName.text = list.tempUser?.userName
//        cell.isUserInteractionEnabled = false
        return cell
    }
}
