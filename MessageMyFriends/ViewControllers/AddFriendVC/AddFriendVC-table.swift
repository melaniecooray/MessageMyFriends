//
//  AddFriendVC-table.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/12/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

extension AddFriendVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.name.text = users[indexPath[1]].firstName + " " + users[indexPath[1]].lastName
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = users[indexPath[1]]
        if selectedFriend.email == UserDefaults.standard.string(forKey: "email") {
            showError(title: "Invalid User:", message: "Can't select yourself")
            tableView.deselectRow(at: indexPath, animated: true)
            return
        } else {
            for friend in currentUser.friends {
                if selectedFriend.userID == friend.userID {
                    showError(title: "Invalid User:", message: "Can't select someone who is already your friend")
                    tableView.deselectRow(at: indexPath, animated: true)
                    return
                }
            }
        }
        
    }
    
    
}
