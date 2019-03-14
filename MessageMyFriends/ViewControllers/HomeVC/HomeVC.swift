//
//  HomeVC.swift
//  MessageMyFriends
//
//  Created by Aadhrik Kuila on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit
import MapKit

class HomeVC: UIViewController {
    
    var titleLabel : UILabel!
    
    var user: User!
    var validUser = true
    
    var friends: [User] = []
    
    var signOutButton: UIBarButtonItem!
    var addFriendButton: UIBarButtonItem!
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var location: CLLocationCoordinate2D!
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if user == nil {
            createUser()
            checkUser()
        } else {
            checkUser()
        }
        if validUser {
            getFriends()
        }
        //initUI()
        setupNavBar()
    }
    
    func createUser() {
        user = User(email: UserDefaults.standard.string(forKey: "email")!, userID: UserDefaults.standard.string(forKey: "userID")!)
        //user.coordinate = location
    }
    
    func checkUser() {
        if user.email == nil || user.firstName == nil || user.lastName == nil {
            validUser = false
            print("found nil")
            //performSegue(withIdentifier: "Config", sender: self)
            performSegue(withIdentifier: "toConfig", sender: self)
            print("performed segue")
        }
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        self.navigationItem.setLeftBarButton(signOutButton, animated: true)
        addFriendButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        self.navigationItem.setRightBarButton(addFriendButton, animated: true)
    }
    
    @objc func signOut() {
        
    }
    
    @objc func addFriend() {
        performSegue(withIdentifier: "addFriend", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing")
        if let resultVC = segue.destination as? ConfigUserVC {
            resultVC.user = user
        }
    }
    
    func centerMap() {
        user.coordinate = location
        let region = MKCoordinateRegion(center: self.location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(region, animated : true)
    }
    
    func getFriends() {
        print("getting friends")
        FirebaseAPIHelper.getFriends(userID: user.userID) { frs in
            print(frs)
            self.friends = frs
            self.initUI()
        }
    }

}
