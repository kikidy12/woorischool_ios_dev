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
