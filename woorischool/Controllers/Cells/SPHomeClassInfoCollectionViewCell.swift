//
//  SPHomeClassInfoCollectionViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class SPHomeClassInfoCollectionViewCell: UICollectionViewCell {
    
    var lectureClassDay: LectureClassDayData!
    
    @IBOutlet weak var attandImageView: UIImageView!
    @IBOutlet weak var classTypeImageView: UIImageView!
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eduTimeLabel: UILabel!
    @IBOutlet weak var prepareLabel: UILabel!
    @IBOutlet weak var homeWorkLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initView(_ data: LectureClassDayData) {
        lectureClassDay = data
        
        guard let lectureClass = lectureClassDay.lectureClass, let lecture = lectureClass.lecture else {
            return
        }
        
        lectureNameLabel.text = lecture.name
        locationLabel.text = "(\(lectureClass.location ?? "미정"))"
        eduTimeLabel.text = lectureClassDay.eduTime
    }
}
