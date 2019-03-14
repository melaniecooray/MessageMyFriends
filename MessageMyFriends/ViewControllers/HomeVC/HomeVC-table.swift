//
//  HomeVC-table.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/13/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendList", for: indexPath) as! UserCell
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        cell.awakeFromNib()
        cell.name.text = friends[indexPath[1]].firstName + " " + friends[indexPath[1]].lastName
        cell.status.text = "Friends"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedFriend = friends[indexPath[1]]
        performSegue(withIdentifier: "toChat", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        print("in selector")
        //let touchPoint = longPressGestureRecognizer.location(in: self.view)
        //if let indexPath = tableView.indexPathForRow(at: touchPoint) {
            displayActionSheet(self)
        //}
        /*
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            print("recognized")
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                // your code here, get the row for the indexPath or do whatever you want
                print("displaying action sheet")
                displayActionSheet(self)
            }
        }
 */
    }
    
    func displayActionSheet(_ sender: Any) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let showAction = UIAlertAction(title: "Show On Map", style: .default) { action in
            //self.mapView.addAnnotation(self.friends[indexPath[1]])
        }
        let locationAction = UIAlertAction(title: "Stop/Resume Sharing Location", style: .default)
        let removeAction = UIAlertAction(title: "Remove Friend", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(showAction)
        optionMenu.addAction(locationAction)
        optionMenu.addAction(removeAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    

    
}
