//
//  AppDelegate-linkhandling.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/11/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

extension AppDelegate {
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        print("doing")
        return userActivity.webpageURL.flatMap(handlePasswordlessSignIn)!
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        print("Sup")
        return application(app, open: url,
                           sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                           annotation: "")
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if handlePasswordlessSignIn(withURL: url) {
            print("Hi")
            return true
        }
        print("not hi")
        return false
    }
 
    
    func handlePasswordlessSignIn(withURL url: URL) -> Bool {
        let link = url.absoluteString
        if Auth.auth().isSignIn(withEmailLink: link) {
            UserDefaults.standard.set(link, forKey: "Link")
            Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "email")!, link: link) { (user, error) in
                
                if let error = error {
                    print("Error Signing In")
                    return
                }
                (self.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: false)
                self.window?.rootViewController?.children[0].performSegue(withIdentifier: "toHomeVCFromLaunch", sender: nil)
            }
            return true
        }
        return false
    }
}
