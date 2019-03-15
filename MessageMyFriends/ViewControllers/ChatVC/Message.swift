//
//  Message.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/14/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation

class Message: Comparable {
    
    var id: String!
    var timeSent: Date!
    var senderID: String!
    var msg: String!
    
    init(message: String, user: String){
        self.msg = message
        self.senderID = user
        self.timeSent = Date()
    }
    
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.timeSent > rhs.timeSent
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }
}
