//
//  FirebaseAPIHelper-chat.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/14/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import MapKit

extension FirebaseAPIHelper {
    static func createChat(user1ID: String, user2ID: String, completion: @escaping (Chat) -> ()) {
        var found = 0
        var toReturn: Chat?
        let ref = Database.database().reference()
        let chatRef = ref.child("chats")
        chatRef.observeSingleEvent(of: .value, with: { (snapshot) in
            for user in snapshot.children {
                let newUser = user as! DataSnapshot
                let dict = newUser.value as! [String:Any]
                let user1 = dict["user1"] as! String
                let user2 = dict["user2"] as! String
                if (user1 == user1ID  || user1 == user2ID) && (user2 == user1ID || user2 == user2ID){
                    found += 1
                    toReturn = Chat(id: dict["chatID"] as! String, user1: dict["user1"] as! String, user2: dict["user2"] as! String)
                }
            }
            
        })
        if (found == 0) {
            let chatID = chatRef.childByAutoId().key
            ref.child("chats").child(chatID!).setValue(["chatID": chatID, "user1": user1ID, "user2": user2ID])
            toReturn = Chat(id: chatID!, user1: user1ID, user2: user2ID)
        }
        completion(toReturn!)
    }
    
    static func listenForChats(chatID: String, onNewMessage: @escaping (Message) -> () ) {
        Database.database().reference().child("chat").child(chatID).observe(.childAdded) { (snap) in
            guard let data = snap.value as? [String: Any?] else {
                return
            }
            
            onNewMessage(Message(msgID: data["messageID"] as! String, message: data["message"] as! String, user: data["sender"] as! String))
            
        }
    }
    
    static func send(chatID: String, msg: Message, completion: @escaping () -> ()) {
        let ref = Database.database().reference()
        let chatRef = ref.child("chats")
        let msgRef = chatRef.child(chatID).child("messages")
        let msgID = msgRef.childByAutoId().key
        msgRef.child(msgID!).setValue(["messageID": msg.id, "message": msg.msg, "sender": msg.senderID])
    }
}
