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
    @IBOutlet weak var messageContainerView: UIView!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var imageTimeLabel: UILabel!
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var messageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    
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
        
        if chat.createdAt.dateToString(formatter: "yyyy-MM-dd") == Date().dateToString(formatter: "yyyy-MM-dd") {
            messageTimeLabel.text = chat.createdAt.dateToString(formatter: "HH:mm")
            imageTimeLabel.text = chat.createdAt.dateToString(formatter: "HH:mm")
        }
        else {
            messageTimeLabel.text = chat.createdAt.dateToString(formatter: "MM/dd")
            imageTimeLabel.text = chat.createdAt.dateToString(formatter: "MM/dd")
        }
        
        if hasPre {
            if chat.imageURL != nil, chat.message != nil, chat.message != "" {
                imageTopConstraint.constant = 0
                messageTopConstraint.constant = 124
            }
            else if chat.imageURL == nil {
                messageTopConstraint.constant = 0
            }
            else {
                imageTopConstraint.constant = 0
                messageTopConstraint.constant = 0
            }
            
            profileImageView.isHidden = true
            nameLabel.isHidden = true
        }
        else {
            if chat.imageURL != nil, chat.message != nil, chat.message != "" {
                imageTopConstraint.constant = 24
                messageTopConstraint.constant = 144
            }
            else if chat.imageURL == nil {
                messageTopConstraint.constant = 24
            }
            else {
                imageTopConstraint.constant = 24
                messageTopConstraint.constant = 24
            }
            profileImageView.isHidden = false
            nameLabel.isHidden = false
        }
        
        if hasNext {
            messageTimeLabel.isHidden = true
            imageTimeLabel.isHidden = true
        }
        else {
            if chat.imageURL == nil {
                imageTimeLabel.isHidden = true
                messageTimeLabel.isHidden = false
            }
            else if chat.message == nil || chat.message == "" {
                imageTimeLabel.isHidden = false
                messageTimeLabel.isHidden = true
            }
            else {
                imageTimeLabel.isHidden = true
                messageTimeLabel.isHidden = false
            }
        }
        
        if let chatImageURL = chat.imageURL {
            chatImageView.kf.setImage(with: chatImageURL)
            imageHeightConstraint.constant = 100
        }
        else {
            imageHeightConstraint.constant = 0
        }
        
        if let message = chat.message, message != "" {
            messageContainerView.isHidden = false
            messageLabel.text = message.decodeEmoji
        }
        else {
            messageContainerView.isHidden = true
        }
        
        nameLabel.text = chat.user.name
    }
}
