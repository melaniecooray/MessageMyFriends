//
//  ChatVC.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/14/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    var user1: User!
    var user2: User!
    
    // ajays 
    var user: User!
    //var messages = [Message]()
    
    var navbar: UINavigationBar!
    var composeBar: UIView!
    
    let composeBarHeight:CGFloat = 70
    
    var composeTextField: UITextField!
    var sendButton: UIButton!
    
    var chatView: UITableView!
    
    
    var navbarBottom: CGFloat!
    var textfieldOffset: CGFloat!
    
    var initialTableviewFrame: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        FirebaseAPIHelper.createChat(user1ID: user1.userID, user2ID: user2.userID)
    }

}
