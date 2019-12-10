//
//  OtherChattingTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/09.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class OtherChattingTableViewCell: UITableViewCell {

    var chat: ChatData!
    var hasPre = false
    var hasNext = false
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var chatImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: ChatData) {
        chat = data
        layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        nameLabel.text = chat.user.name
        if chat.createdAt.dateToString(formatter: "yyyy-MM-dd") == Date().dateToString(formatter: "yyyy-MM-dd") {
            timeLabel.text = chat.createdAt.dateToString(formatter: "HH:mm")
        }
        else {
            timeLabel.text = chat.createdAt.dateToString(formatter: "mm/dd")
        }
        
        if let url = chat.imageURL {
            imageContainerView.isHidden = false
            chatImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "tempImage"))
        }
        else {
            imageContainerView.isHidden = true
        }
        
        if let message = chat.message {
            messageLabel.isHidden = false
            messageLabel.text = message
        }
        else {
            messageLabel.isHidden = true
        }
        
        if hasPre, hasNext {
            profileImageView.isHidden = true
            nameLabel.isHidden = true
            userCountLabel.isHidden = true
            timeLabel.isHidden = true
        }
        else if hasPre, !hasNext {
            profileImageView.isHidden = true
            nameLabel.isHidden = true
            userCountLabel.isHidden = false
            timeLabel.isHidden = false
        }
        
        else if !hasPre, hasNext {
            profileImageView.isHidden = false
            nameLabel.isHidden = false
            userCountLabel.isHidden = true
            timeLabel.isHidden = true
        }
        else {
            profileImageView.isHidden = false
            nameLabel.isHidden = false
            userCountLabel.isHidden = false
            timeLabel.isHidden = false
        }
    }
    
    
    
}
