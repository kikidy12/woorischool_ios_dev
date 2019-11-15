//
//  TeacherStudentAttandTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/29.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherStudentAttandTableViewCell: UITableViewCell {
    
    var attendClouser: ((AttendenceType, UIButton)->())!
    
    var student: UserData!

    @IBOutlet weak var attandStackView: UIStackView!
    @IBOutlet weak var profileImageVIew: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: UserData) {
        student = data
        nameLabel.text = student.name
        infoLabel.text = "\(student.studentInfo.grade ?? 1)학년 \(student.studentInfo.classNumber ?? 1)반 \(student.studentInfo.number ?? 1)번"
        
        if let attendence = student.attendence {
            setAttendBtns(attendence)
        }
        else {
            attandStackView.arrangedSubviews.forEach {
                guard let btn = $0 as? UIButton else {
                    return
                }
                btn.setTitleColor(.brownGrey, for: .normal)
                btn.layer.borderWidth = 1
                btn.backgroundColor = .clear
            }
        }
    }
    
    
    func setAttendBtns(_ type: AttendenceType) {
        attandStackView.arrangedSubviews.forEach {
            guard let btn = $0 as? UIButton else {
                return
            }
            btn.setTitleColor(.brownGrey, for: .normal)
            btn.layer.borderWidth = 1
        }
        
        if type == .absent, let btn = attandStackView.arrangedSubviews.first(where: {$0.tag == 0}) as? UIButton {
            btn.setTitleColor(.white, for: .normal)
            btn.layer.borderWidth = 0
            btn.backgroundColor = .grapefruit
        }
        else if type == .tardy, let btn = attandStackView.arrangedSubviews.first(where: {$0.tag == 1}) as? UIButton {
            btn.setTitleColor(.white, for: .normal)
            btn.layer.borderWidth = 0
            btn.backgroundColor = .blueGrey
        }
        else if type == .attendance, let btn = attandStackView.arrangedSubviews.first(where: {$0.tag == 2}) as? UIButton {
            btn.setTitleColor(.white, for: .normal)
            btn.layer.borderWidth = 0
            btn.backgroundColor = .greenishTeal
        }
    }
    
    @IBAction func seletAttendence(_ sender: UIButton) {
        if sender.tag == 0 {
            attendClouser(.absent, sender)
        }
        if sender.tag == 1 {
            attendClouser(.tardy, sender)
        }
        if sender.tag == 2 {
            attendClouser(.attendance, sender)
        }
    }
}
