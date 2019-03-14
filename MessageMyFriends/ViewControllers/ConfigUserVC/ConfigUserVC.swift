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
        addTapDismiss()
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
        user.title = firstName + " " + lastName
        
        FirebaseAPIHelper.updateUser(firstName: firstName, lastName: lastName, userID: user.userID)
        
        performSegue(withIdentifier: "configuredUser", sender: self)
        
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? HomeVC {
            resultVC.user = user
        }
    }
    
    func addTapDismiss() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    @objc func dismissKeyboard() {
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
    }

}
