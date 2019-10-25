//
//  TeacherHomeTableViewCell.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherHomeTableViewCell: UITableViewCell {
    
    var lectureClass: LectureClassData!
    
    var classNoteClouser: (()->())!
    var classStudentClouser: (()->())!
    var classAttendClouser: (()->())!
    var classIntroductionClouser: (()->())!
    
    
    @IBOutlet weak var classNameAndStuCountLabel: UILabel!
    @IBOutlet weak var eduTimeLabel: UILabel!
    @IBOutlet weak var weekDaysLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func showNoteEvnet() {
        classNoteClouser()
    }
    
    @IBAction func showStudentEvnet() {
        classStudentClouser()
    }
    
    @IBAction func showAttendEvnet() {
        classAttendClouser()
    }
    
    @IBAction func showIntroductionEvnet() {
        classIntroductionClouser()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(_ data: LectureClassData) {
        lectureClass = data
        classNameAndStuCountLabel.text = "\(lectureClass.lecture?.name ?? "") \(lectureClass.name ?? "") (\(0))"
    }
    
}
