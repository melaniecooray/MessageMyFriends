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
    var submitButton : UIButton!
    
    let atCharacter: Character = "@"
    let periodCharacter: Character = "."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
        addTapDismiss()
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
        submitButton.addTarget(self, action: #selector(sendEmailLink), for: .touchUpInside)
        view.addSubview(submitButton)
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
