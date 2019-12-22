//
//  ClassRegistPopupViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/14.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ClassRegistPopupViewController: UIViewController {
    
    let numberFormatter = NumberFormatter()
    var lectureClass: LectureClassData!
    var price: Int = 0
    var point: Int = 0
    var preVC: UIViewController!
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var lasPointLabel: UILabel!
    @IBOutlet weak var usePointBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numberFormatter.numberStyle = .decimal
        point = GlobalDatas.currentUser.childlen.point
        usePointBtn.setTitle("자율 수강권 사용", for: .normal)
        if point - price < 0 {
//            usePointBtn.setTitle("자율 수강권 이용 불가", for: .normal)
//            usePointBtn.backgroundColor = .grapefruit
//            usePointBtn.isUserInteractionEnabled = false
        }
        else {
//            usePointBtn.isUserInteractionEnabled = true
//            usePointBtn.backgroundColor = .greenishTeal
//            usePointBtn.setTitle("자율 수강권 사용", for: .normal)
        }
        
        pointLabel.text = "\(numberFormatter.string(for: point) ?? "0")원"
        lasPointLabel.text = "\(numberFormatter.string(for: price) ?? "0")원"
        
        classNameLabel.text = "\(lectureClass.lecture.name ?? "강의") \(lectureClass.name ?? "클래스")"
    }
    
    @IBAction func usePointEvent() {
//        if point - price < 0 {
//            self.showToast(message: "잔액부족", font: .systemFont(ofSize: 15))
//        }
//        else {
//            registRequest(type: "POINT")
//        }
        registRequest(type: "POINT")
    }
    
    @IBAction func notUsePointEvent() {
        registRequest(type: "NORMAL")
    }
}


extension ClassRegistPopupViewController {
    func registRequest(type: String) {
        let parameters = [
            "lecture_class_id": lectureClass!.id!,
            "type": type
        ] as [String:Any]
        ServerUtil.shared.postLecture(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                if let message = message {
                    if message.contains("신청인원이 초과되") {
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
                    else if message.contains("자율 수강권 포인트가") {
                        self.isUseAblePoint()
                        self.showToast(message: message, font: .systemFont(ofSize: 15))
                    }
                    else {
                        AlertHandler().showAlert(vc: self, message: message, okTitle: "확인")
                    }
                }
                else {
                    AlertHandler().showAlert(vc: self, message: message ?? "ServerError", okTitle: "확인")
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
    
    func isUseAblePoint() {
            let parameters = [
                "lecture_class_id": lectureClass.id!
            ] as [String:Any]
            
            ServerUtil.shared.postPointLectureApply(self, parameters: parameters) { (success, dict, message) in
                guard success, let point = dict?["my_point"] as? Int else {
                    return
                }
                GlobalDatas.currentUser.childlen.point = point
                self.pointLabel.text = "\(self.numberFormatter.string(for: point) ?? "0")원"
                
    //            if possible {
    //                let vc = ClassRegistPopupViewController()
    //                vc.lectureClass = classData
    //                vc.preVC = self
    //                vc.price = price
    //                self.showPopupView(vc: vc)
    //            }
    //            else {
    //                let vc = RegistClassPopupViewController()
    //                vc.lectureClass = classData
    //                vc.preVC = self
    //                self.showPopupView(vc: vc)
    //            }
            }
        }
}

