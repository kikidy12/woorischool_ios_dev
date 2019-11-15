//
//  RegistClassTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistClassTableViewCell: UITableViewCell {
    
    var lectureClass: LectureClassData!
    
    var requestClouser: (()->())!
    
    var numberFormatter = NumberFormatter()
    
    @IBOutlet weak var weekdaysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var registBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func registEvent() {
        requestClouser()
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
        let totalCount = lectureClass.maxPerson ?? 0
        let userCount = lectureClass.applyPerson ?? 0
        
        let attributedString = NSMutableAttributedString(string: "\(userCount)/\(totalCount)", attributes: [
          .font: UIFont(name: "NotoSansCJKkr-Medium", size: 17.0)!,
          .foregroundColor: UIColor.greyishBrown,
          .kern: 0.0
        ])
        attributedString.addAttribute(.foregroundColor, value: UIColor.grapefruit, range: NSRange(location: 0, length: "\(userCount)".count))
        
        countLabel.attributedText = attributedString
        if lectureClass.isApply {
            registBtn.layer.borderWidth = 0
            registBtn.backgroundColor = .greenishTeal
            registBtn.isEnabled = true
            
            
            registBtn.setTitleColor(.white, for: .normal)
            registBtn.setTitle("신청하기", for: .normal)
        }
        else {
            registBtn.layer.borderWidth = 1
            registBtn.backgroundColor = .clear
            registBtn.isEnabled = false
            
            
            registBtn.setTitleColor(.brownGrey, for: .normal)
            registBtn.setTitle("신청완료", for: .normal)
        }
    }
}
