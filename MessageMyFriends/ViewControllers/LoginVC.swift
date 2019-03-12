//
//  LoginVC.swift
//  MessageMyFriends
//
//  Created by Aadhrik Kuila on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {
    
    var titleLabel : UILabel!
    var backButton : UIButton!
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
        
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/5, height: 30))
        backButton.center = CGPoint(x: view.frame.width/5, y: view.frame.height/8)
        backButton.setTitle("< Back", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        backButton.backgroundColor = .black
        backButton.layer.cornerRadius = 8
        backButton.addTarget(self, action: #selector(backToLaunchVC), for: .touchUpInside)
        view.addSubview(backButton)
        
        email = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        email.center = CGPoint(x: view.frame.width/2, y: view.frame.height/3 * 2)
        email.placeholder = "Email"
        email.textColor = .black
        email.autocapitalizationType = UITextAutocapitalizationType.none
        email.autocorrectionType = UITextAutocorrectionType.no
        view.addSubview(email)
        
        submitButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width/2, height: 50))
        submitButton.center = CGPoint(x: view.frame.width/2, y: view.frame.height/5 * 4)
        submitButton.setTitle("Login", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.backgroundColor = .black
        submitButton.titleLabel?.font = UIFont(name: "Avenir", size: 30)
        submitButton.layer.cornerRadius = 14
        submitButton.addTarget(self, action: #selector(sendEmailLink), for: .touchUpInside)
        view.addSubview(submitButton)
    }
    
    @objc func backToLaunchVC() {
        performSegue(withIdentifier: "toLaunchVC", sender: self)
    }
    
    @objc func sendEmailLink() {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://messagemyfriends-d90ba.firebaseapp.com")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        actionCodeSettings.dynamicLinkDomain = "messagemyfriends.page.link"
        Auth.auth().sendSignInLink(toEmail: email.text!, actionCodeSettings: actionCodeSettings) { error in
            if let error = error {
                self.showError(title: "Error", message: "Couldn't send email")
                print(error)
                return
            }
            UserDefaults.standard.set(self.email.text!, forKey: "Email")
            self.showError(title: "Success!", message: "Check your email for the link")
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
