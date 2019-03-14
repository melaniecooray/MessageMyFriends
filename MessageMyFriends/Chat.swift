//
//  Chat.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/14/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation

class Chat {
    
    var id: String!
    var msgs: [Message] = []
    var users: [String] = []
    
    init(id: String, user1: String, user2: String) {
        self.id = id
        self.users.append(user1)
        self.users.append(user2)
    }
    
}
