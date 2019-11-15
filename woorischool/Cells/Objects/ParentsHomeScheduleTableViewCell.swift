//
//  ParentsHomeScheduleTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsHomeScheduleTableViewCell: UITableViewCell {
    
    var dayInfo: LectureClassDayData!

    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var lectureImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: LectureClassDayData) {
        dayInfo = data
        
        classNameLabel.text = "\(dayInfo.lectureClass.lecture.name ?? "과목")(\(dayInfo.lectureClass.location ?? "미정"))"
        timeLabel.text = dayInfo.eduTime
    }
    
}
