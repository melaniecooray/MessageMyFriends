//
//  ChatVC-uisetup.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/14/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import Foundation
import UIKit
import ARMDevSuite

extension ChatVC {
    func initUI() {
        initNav()
        
        navbarBottom = self.navigationController?.navigationBar.frame.height
        textfieldOffset = (composeBarHeight)
        
        initInputControl()
        initTableview()
        keyboardRehandling()
    }
    
    // UI Initialization Helpers
    func initNav() {
        self.title = "Chat Room"
    }
    
    func initInputControl() {
        
        composeBar = UIView(frame: CGRect(x: 0, y: view.frame.maxY - textfieldOffset, width: view.frame.width, height: composeBarHeight))
        composeBar.backgroundColor = .white
        
        
        let verticalIndent: CGFloat = .padding
        let itemHeight: CGFloat = composeBarHeight - 2 * verticalIndent
        
        let sendButtonWidth: CGFloat = 70
        sendButton = UIButton(frame: CGRect(x: view.frame.width - (sendButtonWidth + .padding), y: 0, width: sendButtonWidth, height: composeBar.frame.height))
        sendButton.setTitle("Send", for: .normal)
        
        sendButton.setTitleColor(.flatGrayDark, for: .disabled)
        sendButton.setTitleColor(UIColor.flatSkyBlue, for: .normal)
        sendButton.isEnabled = false
        sendButton.addTarget(self, action: #selector(sendTextMessage), for: .touchUpInside)
        
        composeTextField = UITextField(frame: CGRect(x: .padding, y: verticalIndent, width: (sendButton.frame.minX - 3 * .marginalPadding), height: itemHeight))
        
        //        composeTextField.attributedPlaceholder = NSAttributedString(string: "Aa", attributes: [NSAttributedString.Key.foregroundColor : UIColor.placeholder, NSAttributedString.Key.font: UIFont.text!])
        composeTextField.placeholder = "Aa"
        composeTextField.textColor = .black
        composeTextField.tintColor = .flatSkyBlueDark
        composeTextField.backgroundColor = .flatWhite
        composeTextField.layer.cornerRadius = composeTextField.frame.height/2
        composeTextField.delegate = self
        composeTextField.returnKeyType = .send
        composeTextField.addTarget(self, action: #selector(messageBoxTyped), for: .allEditingEvents)
        
        
        let spacerView = UIView(frame:CGRect(x:0, y:0, width:10, height:10))
        composeTextField.leftViewMode = .always
        composeTextField.leftView = spacerView
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1))
        topBorder.backgroundColor = .flatWhiteDark
        composeBar.addSubview(topBorder)
        
        composeBar.addSubview(composeTextField)
        composeBar.addSubview(sendButton)
        view.addSubview(composeBar)
    }
    
    func initTableview() {
        chatView = UITableView(frame: LayoutManager.between(elementAbove: self.navigationController!.navigationBar, elementBelow: self.composeBar, width: view.frame.width, topPadding: 0, bottomPadding: .marginalPadding*2))
        self.initialTableviewFrame = chatView.frame
        chatView.separatorStyle = .none
        chatView.keyboardDismissMode = .interactive
        chatView.register(ChatCell.self, forCellReuseIdentifier: "chatCell")
        chatView.dataSource = self
        chatView.delegate = self
        chatView.indicatorStyle = .black
        
        chatView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        
        view.addSubview(chatView)
        view.sendSubviewToBack(chatView)
    }
    
    
    func keyboardRehandling() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotification), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
}
