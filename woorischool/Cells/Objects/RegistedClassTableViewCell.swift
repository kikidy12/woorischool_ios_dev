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
    
    var warningHeightConstrint: NSLayoutConstraint!
    
    @IBOutlet weak var weekdaysLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTimeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var readyTitleLabel: UILabel!
    @IBOutlet weak var stateInfoLabel: UILabel!
    @IBOutlet weak var applyBtn: CustomButton!
    @IBOutlet weak var expireTimeWarningLabel: CustomLabel!
    
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
    
    func initView(_ data: LectureClassData, quater: QuaterData) {
        lectureClass = data
        numberFormatter.numberStyle = .decimal
        guard let lecture = lectureClass.lecture, let apply = lectureClass.lectureApply else { return }
        
        layoutIfNeeded()
        warningHeightConstrint = expireTimeWarningLabel.heightAnchor.constraint(equalToConstant: 0)
        nameLabel.text = lecture.name
        teacherNameLabel.text = lectureClass.teacher.name
        priceLabel.text = numberFormatter.string(for: lectureClass.price)
        classNameLabel.text = lectureClass.name
        
        weekdaysLabel.text = lectureClass.daysStr
        countLabel.text = "\(lectureClass.waitCount ?? 0)"
        let count = lectureClass.dayList.count
        if let eduStr = lectureClass.dayList.first?.eduTime {
            if count > 1 {
                let str = "\(eduStr) 외\(count - 1)"
                let attributedString = NSMutableAttributedString(string: str, attributes: [
                  .font: UIFont(name: "NotoSansCJKkr-Medium", size: 13.0)!,
                  .foregroundColor: UIColor.greyishBrown,
                  .kern: 0.0
                ])
                attributedString.addAttribute(.foregroundColor, value: UIColor.greenishTeal, range: NSRange(location: str.count - 2, length: 2))
                classTimeLabel.attributedText = attributedString
            }
            else {
                classTimeLabel.text = eduStr
            }
        }
        else {
            classTimeLabel.text = "-"
        }
        
        if apply.status == "WAIT" {
            if let expireTime = apply.expireTime, expireTime > Date() {
                let str = expireTime.dateToString(formatter: "MM월 dd일 HH:mm")
                let attributedString = NSMutableAttributedString(string: "\(str) 이내에 수강확정이 되지 않으면 \n다음 대기자에게 수강신청 권한이 넘어갑니다", attributes: [
                  .font: UIFont(name: "NotoSansCJKkr-Medium", size: 13.0)!,
                  .foregroundColor: UIColor.grapefruit,
                  .kern: 0.0
                ])
                attributedString.addAttribute(.font, value: UIFont(name: "NotoSansCJKkr-Black", size: 13.0)!, range: NSRange(location: 0, length: str.count))
                expireTimeWarningLabel.attributedText = attributedString
                warningHeightConstrint.isActive = false
                stateInfoLabel.isHidden = true
                applyBtn.isHidden = false
                readyTitleLabel.isHidden = true
                countLabel.isHidden = true
            }
            else {
                applyBtn.isHidden = true
                warningHeightConstrint.isActive = true
                if quater.type == .first {
                    stateInfoLabel.isHidden = true
                    readyTitleLabel.isHidden = false
                    countLabel.isHidden = false
                }
                else {
                    stateInfoLabel.isHidden = false
                    stateInfoLabel.text = "만료"
                    readyTitleLabel.isHidden = true
                    countLabel.isHidden = true
                }
            }
        }
        else {
            stateInfoLabel.isHidden = false
            applyBtn.isHidden = true
            readyTitleLabel.isHidden = true
            countLabel.isHidden = true
            warningHeightConstrint.isActive = true
            
            if apply.status == "CONFIRM" {
                stateInfoLabel.text = "신청이 완료되었습니다"
            }
            else {
                stateInfoLabel.text = "추첨 대기중..."
            }
        }
    }
}
