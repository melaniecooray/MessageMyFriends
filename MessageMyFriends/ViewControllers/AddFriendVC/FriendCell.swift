//
//  FriendCell.swift
//  MessageMyFriends
//
//  Created by Melanie Cooray on 3/12/19.
//  Copyright © 2019 Melanie Cooray. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    var name: UILabel!
    var status: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        name = UILabel(frame: CGRect(x: 20, y: 20, width: contentView.frame.width, height: contentView.frame.height))
        name.font = UIFont(name: "Avenir-Light", size: 15)
        contentView.addSubview(name)
        
        status = UILabel(frame: CGRect(x: 90, y: 20, width: contentView.frame.width, height: contentView.frame.height))
        status.font = UIFont(name: "Avenir-Light", size: 15)
        contentView.addSubview(name)
        
    }
}
