//
//  LoginVC.swift
//  MessageMyFriends
//
//  Created by Aadhrik Kuila on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginVC: UIViewController {
    
    var titleLabel : UILabel!
    var email : UITextField!
    var savedEmail: String!
    var submitButton : UIButton!
    var sendLinkButton: UIButton!
    
    let atCharacter: Character = "@"
    let periodCharacter: Character = "."
    
    var link: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.performSegue(withIdentifier: "toHomeVCFromLogin", sender: self)
            } else {
                self.initUI()
            }
        }
        addTapDismiss()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func toHomeVC() {
        //the commented out code is stuff i used in mdbsocials to verify email (obv we can change it for this)
        /*Database.database().reference().child("user").child(username.text!).observeSingleEvent(of: .value) { (snap) in
            guard let data = snap.value as? [String: Any?] else {return}
            
            let emailstring = data["email"] as! String
            Auth.auth().signIn(withEmail: emailstring, password: self.password.text!) { (auth, err) in
                if let error = err {
                    print(error)
                    return
                }*/
                self.performSegue(withIdentifier: "toHomeVCFromLogin", sender: self)
            /*}
        }*/
    }
    
    @objc func sendEmailLink() {
        print("please")
        savedEmail = email.text!
        if !email.text!.contains(atCharacter) || !email.text!.contains(periodCharacter) || email.text!.count < 5 {
            showError(title: "Error", message: "Email is not valid")
            return
        }
        
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
            UserDefaults.standard.set(self.email.text!, forKey: "email")
            self.showError(title: "Success!", message: "Check your email for the link")
        }
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addTapDismiss() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
    }
    @objc func dismissKeyboard() {
        email.resignFirstResponder()
    }
    
    
}
