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
    
    var showDailyNotiColouser: ((Bool)->())!
    
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var attendImageView: UIImageView!
    @IBOutlet weak var attendLabel: UILabel!
    @IBOutlet weak var attendView: UIView!
    @IBOutlet weak var classTypeImageView: UIImageView!
    @IBOutlet weak var lectureNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var eduTimeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func showDailyNotiVIewEvent(_ sender: Any) {
        if let bool = lectureClassDay?.lectureClass?.lectureSchedule?.isAnnouncement, bool {
            showDailyNotiColouser(true)
        }
        else {
            showDailyNotiColouser(false)
        }
    }
    

    func initView(_ data: LectureClassDayData) {
        lectureClassDay = data
        
        guard let lectureClass = lectureClassDay.lectureClass, let lecture = lectureClass.lecture else {
            return
        }
        
        lectureNameLabel.text = "\(lecture.name ?? "강좌") \(lectureClass.name ?? "클래스")"
        locationLabel.text = "(\(lectureClass.location ?? "미정"))"
        eduTimeLabel.text = lectureClassDay.eduTime
        
        switch lectureClass.attendance {
        case .attendance:
            attendImageView.image = #imageLiteral(resourceName: "attandCheckIcon1")
            attendView.backgroundColor = .greenishTeal
            attendLabel.textColor = .greenishTeal
            attendLabel.text = "출석"
            break
        case .absent:
            attendImageView.image = #imageLiteral(resourceName: "attandCheckIcon2")
            attendView.backgroundColor = .grapefruit
            attendLabel.textColor = .grapefruit
            attendLabel.text = "결석"
            break
        case .tardy:
            attendImageView.image = #imageLiteral(resourceName: "attandCheckIcon2")
            attendView.backgroundColor = .grapefruit
            attendLabel.textColor = .grapefruit
            attendLabel.text = "지각"
            break
        case .none:
            attendImageView.image = #imageLiteral(resourceName: "attandCheckIcon3")
            attendView.backgroundColor = .greyishBrown
            attendLabel.textColor = .brownGrey
            attendLabel.text = "체크전"
        }
    }
}
