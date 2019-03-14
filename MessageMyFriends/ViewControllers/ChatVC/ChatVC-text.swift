//
//  ChatVC-text.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/14/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation
import UIKit

extension ChatVC: UITextFieldDelegate {
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame!.origin.y
            
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0
            
            UIView.animate(withDuration: duration) {
                self.composeBar.frame.origin = CGPoint(x: 0, y: endFrameY - self.textfieldOffset)
                self.chatView.frame.size = CGSize(width: self.initialTableviewFrame.width, height: self.initialTableviewFrame.height - (self.view.frame.height - endFrameY))
            }
            
        }
    }
    
    
    @objc func messageBoxTyped() {
        sendButton.isEnabled = (composeTextField.text != "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendTextMessage()
        return false
    }
    
    
    
    
    
}
