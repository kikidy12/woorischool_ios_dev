//
//  BoardReplyTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardReplyTableViewCell: UITableViewCell {
    
    var isParent = false
    
    var comment: ReplyData!
    
    var showReReListClouser: (()->())?
    var deleteClouser: (()->())?
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var messageImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var rereCountBtn: UIButton!
    @IBOutlet weak var bottomStackView: UIStackView!
    @IBOutlet weak var deleteBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func showReReListEvnet(_ sender: Any) {
        showReReListClouser?()
    }
    
    @IBAction func deleteReplyEvent(_ sender: Any) {
        deleteClouser?()
    }
    
    
    func initView(_ data: ReplyData) {
        comment = data
        if let content = comment.content, !content.isEmpty {
            contentLabel.isHidden = false
            contentLabel.text = content.decodeEmoji
        }
        else {
            contentLabel.isHidden = true
        }
        if comment.commentUser.id == GlobalDatas.currentUser.id, !isParent {
            deleteBtn.isHidden = false
        }
        else {
            deleteBtn.isHidden = true
        }
        nameLabel.text = comment.commentUser.name
        timeLabel.text = comment.writeTime
        imageContainerView.isHidden = false
        if let url = comment.imageUrl {
            print("image : ", url)
            messageImageView.kf.setImage(with: url, placeholder: UIImage(named: "tempImage"))
        }
        
        else if let url = comment.emoticonUrl {
            print("emoticon : ", url)
            messageImageView.kf.setImage(with: url, placeholder: UIImage(named: "tempImage"))
        }
        else {
            imageContainerView.isHidden = true
        }
        
        rereCountBtn.setTitle("+ 댓글 \(comment.reCommentCount ?? 0)개", for: .normal)
    }
}
