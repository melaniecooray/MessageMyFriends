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
    
    var doneButton: UIButton!
    
    var selectedFriend: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        FirebaseAPIHelper.getAllUsers() { usrs in
            self.users = usrs
            self.initUI()
        }
        
        FirebaseAPIHelper.getFriends(userID: currentUser.userID) { frnd in
            if !self.currentUser.friends.contains(frnd) {
                self.currentUser.friends.append(frnd)
            }
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func addFriend() {
        FirebaseAPIHelper.addFriend(userID: currentUser.userID, friendID: selectedFriend.userID)
        performSegue(withIdentifier: "addedFriend", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? HomeVC {
            resultVC.user = currentUser
        }
    }

}
