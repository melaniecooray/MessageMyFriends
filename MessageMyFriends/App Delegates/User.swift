//
//  User.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation
import MapKit

class User: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var userID: String!
    var email: String!
    var firstName: String!
    var lastName: String!
    var friends: [User] = []
    
    var title: String?
    var subtitle: String?
    
    init(email: String, userID: String) {
        self.email = email
        self.userID = userID
        self.coordinate = CLLocationCoordinate2D(latitude: 100, longitude: 100)
        self.title = email
        self.subtitle = "uh"
    }
}
