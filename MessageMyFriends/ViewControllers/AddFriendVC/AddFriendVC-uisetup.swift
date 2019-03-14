//
//  AddFriendVC-uisetup.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/13/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

extension AddFriendVC {
    
    func initUI() {
        setupTable()
        setupDoneButton()
    }
    
    func setupTable() {
        tableView = UITableView(frame: CGRect(x: 0, y: 100, width: view.frame.width, height: 400))
        tableView.register(FriendCell.self, forCellReuseIdentifier: "FriendCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func setupDoneButton() {
        doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        doneButton.center = CGPoint(x: view.frame.width/2, y: tableView.frame.maxY + 100)
        doneButton.setTitle("Add Friend", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.backgroundColor = .black
        doneButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        doneButton.layer.cornerRadius = 14
        doneButton.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        view.addSubview(doneButton)
    }
    
}
