//
//  AddFriendVC.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class AddFriendVC: UIViewController {
    
    var tableView: UITableView!
    
    var users: [User]!
    var currentUser: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        users = FirebaseAPIHelper.getAllUsers()
    }

}
