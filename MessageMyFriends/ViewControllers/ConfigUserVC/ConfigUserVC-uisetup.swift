//
//  ConfigUserVC-uisetup.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/13/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

extension ConfigUserVC {
    
    func initUI() {
        setupFirstName()
        setupLastName()
        setupUpdateButton()
    }
    
    func setupFirstName() {
        firstNameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width - 50, height: 100))
        firstNameTextField.center = CGPoint(x: view.frame.width/2, y: 200)
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.adjustsFontSizeToFitWidth = true
        view.addSubview(firstNameTextField)
    }
    
    func setupLastName() {
        lastNameTextField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width - 50, height: 100))
        lastNameTextField.center = CGPoint(x: view.frame.width/2, y: firstNameTextField.frame.maxY + 100)
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.adjustsFontSizeToFitWidth = true
        view.addSubview(lastNameTextField)
    }
    
    func setupUpdateButton() {
        updateButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        updateButton.center = CGPoint(x: view.frame.width/2, y: lastNameTextField.frame.maxY + 100)
        updateButton.setTitle("Update", for: .normal)
        updateButton.setTitleColor(UIColor.white, for: .normal)
        updateButton.backgroundColor = .black
        updateButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        updateButton.layer.cornerRadius = 14
        updateButton.addTarget(self, action: #selector(updateUser), for: .touchUpInside)
        view.addSubview(updateButton)
    }
}
