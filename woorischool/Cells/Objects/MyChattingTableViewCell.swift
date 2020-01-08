//
//  MyChattingTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/09.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class MyChattingTableViewCell: UITableViewCell {
    var chat: ChatData!
    var hasPre = false
    var hasNext = false
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageContinerView: UIView!
    @IBOutlet weak var messageTimeLabel: UILabel!
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTimeLabel: UILabel!
    @IBOutlet weak var messageTopConstraint: NSLayoutConstraint!
    
    
    
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
        
        if chat.imageURL != nil, chat.message != nil, chat.message != "" {
            messageTopConstraint.constant = 120
        }
        else if chat.imageURL == nil {
            messageTopConstraint.constant = 0
        }
        else {
            messageTopConstraint.constant = 0
        }
        
//        if hasNext {
//            messageTimeLabel.isHidden = true
//            imageTimeLabel.isHidden = true
//        }
//        else {
//            if chat.imageURL == nil {
//                imageTimeLabel.isHidden = true
//                messageTimeLabel.isHidden = false
//            }
//            else if chat.message == nil || chat.message == "" {
//                imageTimeLabel.isHidden = false
//                messageTimeLabel.isHidden = true
//            }
//            else {
//                imageTimeLabel.isHidden = true
//                messageTimeLabel.isHidden = false
//            }
//        }
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

        
        if let chatImageURL = chat.imageURL {
            chatImageView.kf.setImage(with: chatImageURL)
            imageHeightConstraint.constant = 100
        }
        else {
            imageHeightConstraint.constant = 0
        }
        
        if let message = chat.message, message != "" {
            messageContinerView.isHidden = false
            messageLabel.text = message.decodeEmoji
        }
        else {
            messageContinerView.isHidden = true
        }
    }
    
    
}
