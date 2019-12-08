//
//  ClassBoardTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ClassBoardTableViewCell: UITableViewCell {
    
    var board: BoardData!
    
    var isMyBoardList = false
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var imaegContainerView: UIView!
    
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: BoardData) {
        board = data
        
        if isMyBoardList {
            classNameLabel.superview?.isHidden = false
            classNameLabel.text = "\(board?.lectureClass?.lecture?.name ?? "강의명") \(board.lectureClass?.name ?? "클래스명")"
        }
        else {
            classNameLabel.superview?.isHidden = true
        }
        nameLabel.text = board.postingUser.name
        timeLabel.text = board.writeTime
        contentLabel.text = board.content
        likeCountLabel.text = "\(board.likeCount ?? 0)개"
        replyCountLabel.text = "\(board.commentCount ?? 0)개"
        
        if board.imageList.count == 0 {
            imaegContainerView.isHidden = true
        }
        else {
            imaegContainerView.isHidden = false
            self.firstImageView.kf.setImage(with: self.board.imageList.first?.url, placeholder: UIImage(named: "tempImage"))
        }
    }
    
}
