//
//  ReReplyTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ReReplyTableViewCell: UITableViewCell {
    
    var comment: ReplyData!
    
    var deleteClouse: (()->())?
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var imageViewContainerView: UIView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deleteEvent(_ sender: Any) {
        deleteClouse?()
    }
    
    func initView(_ data: ReplyData) {
        comment = data
        
        if comment.commentUser.id == GlobalDatas.currentUser.id {
            deleteBtn.isHidden = false
        }
        else {
            deleteBtn.isHidden = true
        }
        
        if let content = comment.content, !content.isEmpty {
            contentLabel.isHidden = false
            contentLabel.text = comment.content?.decodeEmoji
        }
        else {
            contentLabel.isHidden = true
        }
        nameLabel.text = comment.commentUser.name
        timeLabel.text = comment.writeTime
        imageViewContainerView.isHidden = false
        if let url = comment.imageUrl {
            print("image : ", url)
            replyImageView.kf.setImage(with: url, placeholder: UIImage(named: "tempImage"))
        }
        
        else if let url = comment.emoticonUrl {
            print("emoticon : ", url)
            replyImageView.kf.setImage(with: url, placeholder: UIImage(named: "tempImage"))
        }
        else {
            imageViewContainerView.isHidden = true
        }
        
    }
}


