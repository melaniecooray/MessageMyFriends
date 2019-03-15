//
//  UserCell.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/13/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    var name: UILabel!
    var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name = UILabel(frame: CGRect(x: 20, y: 0, width: 200, height: contentView.frame.height))
        name.font = UIFont(name: "Avenir-Light", size: 15)
        contentView.addSubview(name)
        
        status = UILabel(frame: CGRect(x: 300, y: 20, width: 100, height: contentView.frame.height))
        status.font = UIFont(name: "Avenir-Light", size: 15)
        contentView.addSubview(name)
        
    }
}
