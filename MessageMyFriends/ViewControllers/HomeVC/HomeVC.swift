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
    
    var signOutButton: UIBarButtonItem!
    var addFriendButton: UIBarButtonItem!
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var location: CLLocationCoordinate2D!
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        if user == nil {
            createUser()
            checkUser()
        } else {
            checkUser()
        }
        setupNavBar()
        //setupScreen()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func createUser() {
        user = User(email: UserDefaults.standard.string(forKey: "email")!, userID: UserDefaults.standard.string(forKey: "userID")!)
        //user.coordinate = location
    }
    
    func checkUser() {
        if user.email == nil || user.firstName == nil || user.lastName == nil {
            performSegue(withIdentifier: "toConfig", sender: self)
        }
    }
    
    func setupNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        signOutButton = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut))
        self.navigationItem.setLeftBarButton(signOutButton, animated: true)
        addFriendButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
        self.navigationItem.setRightBarButton(addFriendButton, animated: true)
    }
    
    func setupScreen() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3)
        titleLabel.text = "HOME"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Avenir", size: 30)
        view.addSubview(titleLabel)
    }
    
    @objc func signOut() {
        
    }
    
    @objc func addFriend() {
        performSegue(withIdentifier: "addFriend", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ConfigUserVC {
            resultVC.user = user
        }
    }
    
    func centerMap() {
        user.coordinate = location
        var region = MKCoordinateRegion(center: self.location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        self.mapView.setRegion(region, animated : true)
    }

}
