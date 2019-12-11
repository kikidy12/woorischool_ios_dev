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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageMessageDivideHeightCnstraint: NSLayoutConstraint!
    @IBOutlet weak var imageTimeLabel: UILabel!
    
    
    
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
            timeLabel.text = chat.createdAt.dateToString(formatter: "HH:mm")
            imageTimeLabel.text = chat.createdAt.dateToString(formatter: "HH:mm")
        }
        else {
            timeLabel.text = chat.createdAt.dateToString(formatter: "mm/dd")
            imageTimeLabel.text = chat.createdAt.dateToString(formatter: "HH:mm")
        }

        imageMessageDivideHeightCnstraint.constant = 20
        
        if let message = chat.message, message != "" {
            messageLabel.text = message
            messageContinerView.isHidden = false
            showTimeLabel(label: timeLabel, show: true)
        }
        else {
            messageContinerView.isHidden = true
            imageMessageDivideHeightCnstraint.constant = 0
            showTimeLabel(label: timeLabel, show: false)
        }
        if let url = chat.imageURL {
            imageHeightConstraint.constant = 100
            chatImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "tempImage"))
            showTimeLabel(label: imageTimeLabel, show: true)
        }
        else {
            imageTimeLabel.isHidden = true
            imageHeightConstraint.constant = 0
            imageMessageDivideHeightCnstraint.constant = 0
            showTimeLabel(label: imageTimeLabel, show: false)
        }
        
        if chat.imageURL != nil, chat.message != nil {
            showTimeLabel(label: timeLabel, show: true)
            showTimeLabel(label: imageTimeLabel, show: false)
        }
        
        
    }
    
    func showTimeLabel(label: UILabel, show: Bool) {
        if show {
            if (hasPre && !hasNext) || (!hasPre && !hasNext) {
                label.isHidden = false
            }
            else {
                label.isHidden = true
            }
        }
        else {
            label.isHidden = true
        }
    }
    
}
