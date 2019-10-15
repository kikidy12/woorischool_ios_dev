//
//  RegistCompClassTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistCompClassTableViewCell: UITableViewCell {
    
    
    var lectureClass: LectureClassData!
    
    var requestClouser: (()->())!
    
    var numberFormatter = NumberFormatter()
    
    @IBOutlet weak var weekdaysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func initView(_ data: LectureClassData) {
        lectureClass = data
        numberFormatter.numberStyle = .decimal
        guard let lecture = lectureClass.lecture else { return }
        
        nameLabel.text = lecture.name
        teacherNameLabel.text = lectureClass.teacher.name
        priceLabel.text = numberFormatter.string(for: lectureClass.price)
        classNameLabel.text = lectureClass.name
        
        weekdaysLabel.text = lectureClass.daysStr
        
        if let eduStr = lectureClass.dayList.first?.eduTime {
            classTimeLabel.text = eduStr
        }
        else {
            classTimeLabel.text = "-"
        }
    }
}
