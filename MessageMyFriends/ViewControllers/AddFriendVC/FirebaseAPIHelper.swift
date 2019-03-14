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
import MapKit

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
            }
            
        })
        if (found == 0) {
            let userID = userRef.childByAutoId().key
            UserDefaults.standard.set(userID, forKey: "userID")
            ref.child("users").child(userID!).setValue(["userID": userID, "email": email, "friends": [userID]])
        }
    }
    
    static func getUserData(userID: String, completion: @escaping (User) -> ()) {
        print("getting user data")
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var toReturn: User?
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                let observedUID = dict["userID"] as! String
                print(observedUID)
                print(userID)
                if observedUID == userID {
                    toReturn = User(email: dict["email"] as! String, userID: dict["userID"] as! String)
                    toReturn?.firstName = dict["firstName"] as! String
                    toReturn?.lastName = dict["lastName"] as! String
                    if let latitude = dict["latitude"] as? Double {
                        if let longitude = dict["longitude"] as? Double {
                            toReturn?.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        }
                    }
                }
            }
            completion(toReturn!)
        })
    }
    
    static func createChat(user1ID: String, user2ID: String) {
        var found = 0
        let ref = Database.database().reference()
        let chatRef = ref.child("chats")
        chatRef.observe(.value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                let user1 = dict["user1"] as! String
                let user2 = dict["user2"] as! String
                if (user1 == user1ID  || user1 == user2ID) && (user2 == user1ID || user2 == user2ID){
                    found += 1
                }
            }
            
        })
        if (found == 0) {
            let chatID = chatRef.childByAutoId().key
            ref.child("chats").child(chatID!).setValue(["chatID": chatID, "user1": user1ID, "user2": user2ID])
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
    
    static func updateTime(userID: String, time: String) {
        let ref = Database.database().reference()
        ref.child("users").child(userID).updateChildValues(["time": time])
    }
    
    static func getAllUsers(completion: @escaping ([User]) -> ()) {
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
            completion(users)
            
        })
    }
    
    static func addFriend(userID: String, friendID: String) {
        var userFavs: [String] = []
        var friendFavs: [String] = []
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        userRef.observe(.value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                if dict["userID"] as! String == userID {
                    userFavs = dict["friends"] as! [String]
                }
                if dict["userID"] as! String == friendID {
                    friendFavs = dict["friends"] as! [String]
                }
            }
        })
        userFavs.append(friendID)
        friendFavs.append(userID)
        ref.child("users").child(userID).updateChildValues(["friends": userFavs])
        ref.child("users").child(friendID).updateChildValues(["friends": friendFavs])
    }
    
    static func getFriends(userID: String, completion: @escaping (User) -> ()) {
        let ref = Database.database().reference()
        let userRef = ref.child("users")
        var friends: [String] = []
        var returnFriends: [User] = []
        userRef.observe(.value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                if dict["userID"] as? String == userID {
                    friends = dict["friends"] as! [String]
                }
            }
            userRef.observe(.value, with: { (snapshot2) in
                for user in snapshot2.children {
                    let newUser2 = user as! DataSnapshot
                    let dict2 = newUser2.value as! [String:Any]
                    if friends.contains(dict2["userID"] as! String) {
                        let toReturn = User(email: dict2["email"] as! String, userID: dict2["userID"] as! String)
                        toReturn.firstName = dict2["firstName"] as? String
                        toReturn.lastName = dict2["lastName"] as? String
                        toReturn.subtitle = dict2["time"] as? String
                        let latitude = dict2["latitude"] as! Double
                        let longitude = dict2["longitude"] as! Double
                        toReturn.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                        completion(toReturn)
                        //toReturn.coordinate = CLLocationCoordinate2D(latitude: dict["latitude"] as! CLLocationDegrees, longitude: dict["longitude"] as! CLLocationDegrees)
                        returnFriends.append(toReturn)
                    }
                }
            })
        })
        //completion(returnFriends)
    }
    
}
