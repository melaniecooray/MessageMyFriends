//
//  LoginVC.swift
//  MessageMyFriends
//
//  Created by Aadhrik Kuila on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    var titleLabel : UILabel!
    var email : UITextField!
    var submitButton : UIButton!
    
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
        
        email = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        email.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        email.placeholder = "Email"
        email.textColor = .black
        email.autocapitalizationType = UITextAutocapitalizationType.none
        email.autocorrectionType = UITextAutocorrectionType.no
        view.addSubview(email)
        
        submitButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        submitButton.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3 * 2)
        submitButton.setTitle("Login", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.backgroundColor = .black
        submitButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        submitButton.layer.cornerRadius = 14
        //submitButton.addTarget(self, action: #selector(openLoginVC), for: .touchUpInside)
        view.addSubview(submitButton)
    }
    
}
