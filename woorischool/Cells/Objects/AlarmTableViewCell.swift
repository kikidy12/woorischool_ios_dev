//
//  AlarmTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    
    var alarm: AlarmData!
    @IBOutlet weak var typeLabel: CustomLabel!
    @IBOutlet weak var titleLabel: UILabel!
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
    
    func initView(_ data: AlarmData) {
        alarm = data
        layoutIfNeeded()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        if let type = alarm.type {
            typeLabel.text = type
            typeLabel.backgroundColor = .greenishTeal
        }
        else {
            typeLabel.text = "미정"
            typeLabel.backgroundColor = .greenishTeal
        }
        
        titleLabel.text = alarm.title
        contentLabel.text = alarm.content
        timeLabel.text = alarm.time
    }
    
}
