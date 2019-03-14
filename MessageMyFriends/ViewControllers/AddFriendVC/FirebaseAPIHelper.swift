//
//  FirebaseAPIHelper-account.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/12/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseAPIHelper {
    
    static func signInUser(email: String) {
        print("adding to firebase")
        var found = 0
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observe(.value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                let observedEmail = dict["email"] as! String
                if observedEmail == email {
                    found += 1
                }
                print(found)
            }
            
        })
        if (found == 0) {
            let userID = userRef.childByAutoId().key
            UserDefaults.standard.set(userID, forKey: "userID")
            ref.child("users").child(userID!).setValue(["userID": userID, "email": email, "friends": []])
        }
    }
    
    static func updateUser(firstName: String, lastName: String, userID: String) {
        let ref = Database.database().reference()
        ref.child("users").child(userID).updateChildValues(["firstName": firstName, "lastName": lastName])
        
    }
    
    static func updateLocation(userID: String, latitude: Double, longitude: Double) {
        let ref = Database.database().reference()
        ref.child("users").child(userID).updateChildValues(["latitude": latitude, "longitude": longitude])
    }
    
    static func getAllUsers() -> [User] {
        var users : [User] = []
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observe(.value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                let toAppend = User(email: dict["email"] as! String, userID: dict["userID"] as! String)
                toAppend.firstName = dict["firstName"] as? String
                toAppend.lastName = dict["lastName"] as? String
                users.append(toAppend)
            }
            
        })
        return users
    }
    
    static func addFriend() {
        let ref = Database.database().reference()
        ref.child("users")
    }
    
}
