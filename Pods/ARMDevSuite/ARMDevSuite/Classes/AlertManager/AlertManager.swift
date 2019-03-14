//
//  AlertManager.swift
//  ARMDevSuite
//
//  Created by Ajay Merchia on 2/7/19.
//

import Foundation
import UIKit
import JGProgressHUD

public class AlertManager {
    private var vc: UIViewController!
    private(set) public var callback: (() -> ())?
    public var hud: JGProgressHUD?
    
    // Yes or No Question Variables
    
    /// Affirmative option displayed in UIAlerts
    public var affirmativePrompt = "Yes"
    /// Negatory option displayed in UIAlerts
    public var negatoryPrompt = "No"
    
    
    /// How long the hud will wait before disappearing when failure or success is triggered
    public var hudResponseWait = 1.5
    
    
    /// Creates an AlertManager for this ViewController
    ///
    /// - Parameter vc: ViewController in which alerts will display
    public init(vc: UIViewController) {
        self.vc = vc
    }
    
    
    /// Creates an AlertManager for this ViewController that triggers a callback when alerts are fired.
    ///
    /// - Parameters:
    ///   - vc: ViewController in which alerts will display
    ///   - defaultHandler: callback triggered after every call to displayAlert
    public init(vc: UIViewController, defaultHandler: @escaping (() -> ()) ) {
        self.vc = vc
        callback = defaultHandler
    }
    
    
    /// Displays a UIAlert with a title, message, and dismiss button. Triggers callback.
    ///
    /// - Parameters:
    ///   - title: Title of the alert
    ///   - message: Message displayed on the alert
    ///   - dismissPrompt: Message displayed on the alert.
    public func displayAlert(titled title: String?, withDetail message: String?, dismissPrompt: String = "Ok") {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissPrompt, style: .default, handler: nil)
        alert.addAction(defaultAction)
        vc.present(alert, animated: true, completion: nil)
        callback?()
    }
    
    
    /// Asks a binary question with help text, returns user response.
    ///
    /// - Parameters:
    ///   - question: Question to be asked
    ///   - helpText: Any help text in a smaller font
    ///   - onAnswer: Returns whether if the affirmative response was selected
    public func askYesOrNo(question: String, helpText: String?, onAnswer: @escaping (Bool) -> ()) {
        
        let alert = UIAlertController(title: question, message: helpText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: affirmativePrompt, style: .default, handler: { (_) in
            onAnswer(true)
        }))
        alert.addAction(UIAlertAction(title: negatoryPrompt, style: .destructive, handler: { (_) in
            
            onAnswer(false)
        }))
        
        vc.present(alert, animated: true) {
            self.resetDefaultText()
        }
        
    }
    
    
    /// Starts a JGProgressHUD with the provided message and style.
    ///
    /// - Parameters:
    ///   - withTitle: Title displayed on the HUD
    ///   - withDetail: Details displayed on the HUD
    ///   - style: Determines the coloring of the HUD
    public func startProgressHud(withTitle:String, withDetail: String? = nil, style: JGProgressHUDStyle = .light) {
        self.hud = JGProgressHUD(style: style)
        self.hud?.textLabel.text = withTitle
        self.hud?.detailTextLabel.text = withDetail
        self.hud?.show(in: self.vc.view)
    }
    
    
    @available(iOS 10.0, *)
    /// Shows a failure message on the HUD and then fades away.
    ///
    /// - Returns: nil
    public func triggerHudFailure(withHeader: String?, andDetail: String?, onComplete: @escaping() -> () = {}) {
        hud?.indicatorView = JGProgressHUDErrorIndicatorView(contentView: vc.view)
        changeHUD(toTitle: withHeader, andDetail: andDetail)
        self.hud?.dismiss(afterDelay: hudResponseWait, animated: true)
        Timer.scheduledTimer(withTimeInterval: hudResponseWait, repeats: false) { (t) in
            onComplete()
        }
    }
    
    @available(iOS 10.0, *)
    /// Shows a success message on the HUD and then fades away.
    ///
    /// - Returns: nil
    public func triggerHudSuccess(withHeader: String?, andDetail: String?, onComplete: @escaping() -> () = {}) {
        hud?.indicatorView = JGProgressHUDSuccessIndicatorView(contentView: vc.view)
        changeHUD(toTitle: withHeader, andDetail: andDetail)
        self.hud?.dismiss(afterDelay: hudResponseWait, animated: true)
        Timer.scheduledTimer(withTimeInterval: hudResponseWait, repeats: false) { (t) in
            onComplete()
        }

    }
    
    /// Changes the message displayed on the HUD
    ///
    /// - Parameters:
    ///   - toTitle: Title displayed on the HUD
    ///   - andDetail: Details displayed on the HUD
    public func changeHUD(toTitle: String?, andDetail: String?) {
        if let title = toTitle {
            self.hud?.textLabel.text = title
        }
        if let detail = andDetail {
            self.hud?.detailTextLabel.text = detail
        }
    }
    

    
    /// Requests textual input from the user via an alert.
    ///
    /// - Parameters:
    ///   - withTitle: Title displayed on the Alert
    ///   - andHelp: Details displayed on the Alert
    ///   - andPlaceholder: Placeholder text in the textfield
    ///   - placeholderAsText: Renders the placeholder as typed text instead of a placeholder
    ///   - completion: Called with the contents of the textfield on complete.
    ///   - cancellation: Called alert is dismissed
    public func getTextInput(withTitle: String, andHelp: String?, andPlaceholder: String, placeholderAsText: Bool = false,  completion: @escaping (String) -> (), cancellation: @escaping () -> () = {}) {
        let alert = UIAlertController(title: withTitle, message: andHelp, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: { textField in
            if placeholderAsText {
                textField.text = andPlaceholder
            } else {
                textField.placeholder = andPlaceholder
                
            }
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            _ in
            cancellation()
        }))
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            guard let response = alert.textFields?.first?.text else {
                cancellation()
                return
            }
            completion(response)
        }))
        
        vc.present(alert, animated: true)
    }
    
   
    
    /// Shows an Action Sheet with Title & Detail along with given ActionConfigs
    ///
    /// - Parameters:
    ///   - withTitle: Title displayed on the action sheet
    ///   - andDetail: Detail displayed on the action sheet
    ///   - configs: titles, styles, and callbacks for each action item.
    public func showActionSheet(withTitle: String?, andDetail: String?, configs: [ActionConfig]) {
        
        let actionSheet = UIAlertController(title: withTitle, message: andDetail, preferredStyle: .actionSheet)
        
        for config in configs {
            actionSheet.addAction(UIAlertAction(title: config.title, style: config.style, handler: { (_) in
                guard let callback = config.callback else {
                    return
                }
                callback()
            }))
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.popoverPresentationController?.sourceView = vc.view
        
        vc.present(actionSheet, animated: true)
        
    }
    
    private func resetDefaultText() {
        affirmativePrompt = "Yes"
        negatoryPrompt = "No"
    }
    
    
    
}

public struct ActionConfig {
    public var title: String
    public var style: UIAlertAction.Style
    public var callback: (()->())?
    
    
    /// Creates an ActionConfig with the given title, style, and callback.
    public init(title: String, style: UIAlertAction.Style, callback: (()->())?) {
        self.title = title
        self.style = style
        self.callback = callback
    }
}
    
