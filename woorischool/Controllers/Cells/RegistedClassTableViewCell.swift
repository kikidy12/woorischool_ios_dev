//
//  RegistedClassTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistedClassTableViewCell: UITableViewCell {
    
    
    var lectureClass: LectureClassData!
    
    var requestClouser: (()->())!
    
    var cancelClouser: (()->())!
    
    var numberFormatter = NumberFormatter()
    
    @IBOutlet weak var weekdaysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var applyBtn: CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func registEvent() {
        requestClouser()
    }
    
    @IBAction func cancelEvent() {
        cancelClouser()
    }
    
    func initView(_ data: LectureClassData, type: String) {
        lectureClass = data
        numberFormatter.numberStyle = .decimal
        guard let lecture = lectureClass.lecture else { return }
        
        nameLabel.text = lecture.name
        teacherNameLabel.text = lectureClass.teacher.name
        priceLabel.text = numberFormatter.string(for: lectureClass.price)
        classNameLabel.text = lectureClass.name
        
        weekdaysLabel.text = lectureClass.daysStr
        countLabel.text = "\(lectureClass.waitCount ?? 0)"
        
        if let eduStr = lectureClass.dayList.first?.eduTime {
            classTimeLabel.text = eduStr
        }
        else {
            classTimeLabel.text = "-"
        }
        
        if type == "APPLY" {
            applyBtn.isHidden = false
        }
        else {
            applyBtn.isHidden = true
        }
    }
}
