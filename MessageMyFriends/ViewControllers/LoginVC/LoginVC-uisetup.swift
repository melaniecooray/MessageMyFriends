//
//  LoginVC-uisetup.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

extension LoginVC {
    
    func initUI() {
        setupTitle()
        setupEmail()
        setupSubmitButton()
    }
    
    func setupTitle() {
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/4))
        titleLabel.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3)
        titleLabel.text = "Message My Friends!"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "Avenir", size: 30)
        view.addSubview(titleLabel)
    }
    
    func setupEmail() {
        email = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width/2 + 150, height: 50))
        email.center = CGPoint(x: view.frame.width/2, y: view.frame.height/2)
        email.placeholder = "Email"
        email.textColor = .black
        email.autocapitalizationType = UITextAutocapitalizationType.none
        email.autocorrectionType = UITextAutocorrectionType.no
        view.addSubview(email)
    }
    
    func setupSubmitButton() {
        sendLinkButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        sendLinkButton.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3 * 2)
        sendLinkButton.setTitle("Send Link", for: .normal)
        sendLinkButton.setTitleColor(UIColor.white, for: .normal)
        sendLinkButton.backgroundColor = .black
        sendLinkButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        sendLinkButton.layer.cornerRadius = 14
        sendLinkButton.addTarget(self, action: #selector(sendEmailLink), for: .touchUpInside)
        view.addSubview(sendLinkButton)
    }

    
}
