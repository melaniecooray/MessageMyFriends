//
//  HomeVC-uisetup.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/13/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit
import MapKit

extension HomeVC {
    
    func initUI() {
        setupMap()
        setupTable()
    }
    
    func setupMap() {
        mapView = MKMapView(frame: CGRect(x: 0, y: (self.navigationController?.navigationBar.frame.maxY)!, width: view.frame.width, height: 300))
        mapView.delegate = self
        view.addSubview(mapView)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //centerMap()
        if(CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            self.locationManager.requestLocation()
        }
    }
    
    func setupTable() {
        tableView = UITableView(frame: CGRect(x: 0, y: mapView.frame.maxY, width: view.frame.width, height: 300))
        tableView.register(UserCell.self, forCellReuseIdentifier: "FriendList")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        view.addSubview(tableView)
    }
    
}
