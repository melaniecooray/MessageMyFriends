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
        var found = false
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observe(.value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                let observedEmail = dict["email"] as! String
                if observedEmail == email {
                    found = true
                }
            }
            
        })
        if !found {
            let userID = userRef.childByAutoId().key
            UserDefaults.standard.set(userID, forKey: "userID")
            ref.child("users").child(userID!).setValue(["userID": userID, "email": email])
        }
    }
    
    static func updateUser(firstName: String, lastName: String) {
        let ref = Database.database().reference()
        let userRef = ref.child("users")
    }
    
}
