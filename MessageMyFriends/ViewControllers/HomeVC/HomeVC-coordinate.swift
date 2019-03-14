//
//  HomeVC-coordinate.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/13/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import CoreLocation

extension HomeVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last?.coordinate
        centerMap()
        FirebaseAPIHelper.updateLocation(userID: user.userID, latitude: Double(location.latitude), longitude: Double(location.longitude))
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
