//
//  ChattingRoomTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChattingRoomTableViewCell: UITableViewCell {
    
    var room: ChatRoomData!

    @IBOutlet weak var roomTitleImageView: CircleImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: ChatRoomData) {
        room = data
        self.layoutIfNeeded()
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        titleLabel.text = room.title?.decodeEmoji
        bodyLabel.text = room.body?.decodeEmoji
        lastTimeLabel.text = room.lastMessageTime
    }
    
}
