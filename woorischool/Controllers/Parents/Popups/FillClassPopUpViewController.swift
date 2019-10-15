//
//  FillClassPopUpViewController.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class FillClassPopUpViewController: UIViewController {
    
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

    @IBAction func waitRequestEvent() {
        waitClass()
    }
}

extension FillClassPopUpViewController {
    func waitClass() {
        let parameters = [
            "lecture_class_id": lectureClass.id!
        ] as [String:Any]
        ServerUtil.shared.postLectureWait(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "serverError", okTitle: "확인")
                return
            }
            
            self.dismiss(animated: true) {
                self.closeClouser()
            }
        }
    }
}
