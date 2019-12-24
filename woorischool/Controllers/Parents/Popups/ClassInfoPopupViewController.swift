//
//  ClassInfoPopupViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/10.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ClassInfoPopupViewController: UIViewController {
    
    let numberFormatter = NumberFormatter()
    
    var lectureClass: LectureClassData!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weekDaysLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberFormatter.numberStyle = .decimal
        
        guard let lecture = lectureClass.lecture, let teacher = lectureClass.teacher else {
            return
        }
        
        nameLabel.text = lecture.name
        classNameLabel.text = lectureClass.name
        gradeLabel.text = lectureClass.gradeStr()
        priceLabel.text = "\(numberFormatter.string(for: lectureClass.price) ?? "0")"
        materialLabel.text = lectureClass.material
        teacherNameLabel.text = teacher.name
        
        timeLabel.text = lectureClass.dayList.enumerated().reduce("") {
            if $1.offset == 0 {
                return "\($0 ?? "")\($1.element.eduTime)(\($1.element.day!))"
            }
            else {
                return "\($0 ?? "")\n\($1.element.eduTime)(\($1.element.day!))"
            }
        }
        
        weekDaysLabel.text = lectureClass.dayList.enumerated().reduce("") {
            guard let pre = $0, let day = $1.element.day else {
                return ""
            }
            
            if $1.offset == 0 {
                return "\(day)"
            }
            else {
                return "\(pre)/\(day)"
            }
        }
        weekLabel.text = "\(lectureClass.classTime ?? "")(\(lecture.week ?? 0))"
        placeLabel.text = lectureClass.location

    }

}
