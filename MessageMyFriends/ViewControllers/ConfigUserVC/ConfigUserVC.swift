//
//  ConfigUserVC.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class ConfigUserVC: UIViewController {
    
    var user: User!
    
    var firstNameTextField: UITextField!
    var lastNameTextField: UITextField!
    
    var updateButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initUI()
    }
    
    @objc func updateUser() {
        guard let firstName = firstNameTextField.text else {
            showError(title: "Information Missing:", message: "First Name not entered")
            return
        }
        
        guard let lastName = lastNameTextField.text else {
            showError(title: "Information Missing:", message: "Last Name not entered")
            return
        }
        
        user.firstName = firstName
        user.lastName = lastName
        
        
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }

}
