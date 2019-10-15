//
//  ConfirmClassViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/14.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ConfirmClassViewController: UIViewController {

    var lectureClass: LectureClassData!
    
    var preVC: UIViewController!
    
    var closeClouser: (()->())!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let lecture = lectureClass.lecture else {
            return
        }
        
        nameLabel.text = lecture.name
        var weekDaysStr = ""
        lectureClass.dayList.forEach {
            weekDaysStr += $0.day
            if $0 != lectureClass.dayList.last {
                weekDaysStr += "/"
            }
        }
        
        gradeLabel.text = lectureClass.gradeStr() + "학년"
        classNameLabel.text = lectureClass.name
    }

    @IBAction func ConfirmEvent() {
        confirmClass()
    }
}


extension ConfirmClassViewController {
    func confirmClass() {
        let parameters = [
            "lecture_apply_id": lectureClass.applyId!
        ] as [String:Any]
        ServerUtil.shared.patchLectureApply(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.closeClouser()
        }
    }
}
