//
//  LaunchVC.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    var titleLabel : UILabel!
    var loginButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupScreen() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3)
        titleLabel.text = "Message My Friends!"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Avenir", size: 30)
        view.addSubview(titleLabel)
        
        loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        loginButton.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3 * 2)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor = .black
        loginButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        loginButton.layer.cornerRadius = 14
        loginButton.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    @objc func openLoginVC() {
        performSegue(withIdentifier: "toLoginVC", sender: self)
    }

    //func to check if they r logged in and automatically go to HomeVC
    
}

