//
//  RegistClassPopupViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/10.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistClassPopupViewController: UIViewController {
    
    var lectureClass: LectureClassData!
    
    var preVC: UIViewController!
    
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

    @IBAction func registEvent() {
        registRequest()
    }
}

extension RegistClassPopupViewController {
    func registRequest() {
        let parameters = [
            "lecture_class_id": lectureClass!.id!,
            "type": "NORMAL"
        ] as [String:Any]
        ServerUtil.shared.postLecture(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                if let message = message, message.contains("신청인원이 초과되") {
                    self.dismiss(animated: true) {
                        let vc = FillClassPopUpViewController()
                        vc.lectureClass = self.lectureClass
                        vc.closeClouser = {
                            if let pre = self.preVC as? CourseRegistrationViewController {
                                pre.getLectureClass()
                            }
                        }
                        self.preVC.showPopupView(vc: vc)
                    }
                }
                else {
                    AlertHandler().showAlert(vc: self, message: message ?? "serverError", okTitle: "확인")
                }
                
                return
            }
            
            self.dismiss(animated: true) {
                if let pre = self.preVC as? CourseRegistrationViewController {
                    pre.getLectureClass()
                }
            }
        }
    }
}
