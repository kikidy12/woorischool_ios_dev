//
//  NotiTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class NotiTableViewCell: UITableViewCell {
    
    var noti: NoticeData! {
        didSet {
            titleLabel.text = noti.title
            createTimeLabel.text = noti.cretedAt.dateToString(formatter: "MM/dd")
            isNewImageView.isHidden = true
            contentLabel.text = noti.content
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var isNewImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
