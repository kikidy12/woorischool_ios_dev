//
//  ClassInfoViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/26.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ClassInfoViewController: UIViewController {
    
    var lectureClassId: Int!
    
    var lectureClass: LectureClassData! {
        didSet {
            if lectureClass != nil {
                setClassInfo(lectureClass: lectureClass)
            }
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classPeriodLabel: UILabel!
    @IBOutlet weak var evalStateBtn: UIButton!
    @IBOutlet weak var isStudyLabel: UILabel!
    @IBOutlet weak var ratingPeriodLabel: UILabel!
    
    @IBOutlet weak var totalCoutLabel: UILabel!
    @IBOutlet weak var attendanceCountLabel: UILabel!
    @IBOutlet weak var tardyCountLabel: UILabel!
    @IBOutlet weak var absentCountLabel: UILabel!
    
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
        
        getLectureDetail()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }

    
    func setClassInfo(lectureClass: LectureClassData) {
        guard let lecture = lectureClass.lecture, let teacher = lectureClass.teacher else {
            return
        }
        
        nameLabel.text = lecture.name
        classNameLabel.text = lectureClass.name
        gradeLabel.text = lectureClass.gradeStr()
        priceLabel.text = "\(lectureClass.price.decimalString ?? "0")"
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
        
        classPeriodLabel.text = lectureClass.classPeriod
        evalStateBtn.layer.borderColor = UIColor.brownGrey.cgColor
        switch lectureClass.requestStatus {
        case .requested:
            evalStateBtn.layer.borderWidth = 1
            evalStateBtn.backgroundColor = .clear
            evalStateBtn.setTitleColor(.brownGrey, for: .normal)
            break
        case .completion:
            evalStateBtn.layer.borderWidth = 0
            evalStateBtn.backgroundColor = .dodgerBlue
            evalStateBtn.setTitleColor(.white, for: .normal)
            break
        case .needRequest:
            evalStateBtn.layer.borderWidth = 0
            evalStateBtn.backgroundColor = .greenishTeal
            evalStateBtn.setTitleColor(.white, for: .normal)
            break
        }
        evalStateBtn.setTitle(lectureClass.requestStatus.rawValue, for: .normal)
        ratingPeriodLabel.text = "평가기간 \(lectureClass.ratingPeriod ?? "-")"
        
        if lectureClass.isStudy {
            isStudyLabel.text = "분기 진행중"
            isStudyLabel.backgroundColor = .ice
            isStudyLabel.textColor = .greenishTeal
        }
        else {
            
            isStudyLabel.text = "분기 완료"
            isStudyLabel.backgroundColor = .paleGrey
            isStudyLabel.textColor = .brownGrey
        }
    }
    
    @IBAction func ratingRequestEvnet(_ sender: UIButton) {
        if lectureClass.requestStatus == .requested {
            cancleRating()
        }
        else if lectureClass.requestStatus == .needRequest {
            requestRating()
        }
    }
    
    @IBAction func showBoardListEvent() {
        let vc = ClassBoardListViewController()
        vc.lectureClass = self.lectureClass
        self.show(vc, sender: nil)
    }
    
    @IBAction func showOneToOneChatViewEvent() {
        getOneToOneChat()
    }
}


extension ClassInfoViewController {
    
    func cancleRating() {
        let parameters = [
            "lecture_apply_id": lectureClass.lectureApply.id!
        ] as [String:Any]
        ServerUtil.shared.patchLectureRating(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.getLectureDetail()
        }
    }
    
    func requestRating() {
        let parameters = [
            "lecture_apply_id": lectureClass.lectureApply.id!
        ] as [String:Any]
        ServerUtil.shared.putLectureRating(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            self.getLectureDetail()
        }
    }
    
    func getLectureDetail() {
        let parameters = [
            "lecture_class_id": lectureClassId!
        ] as [String:Any]
        
        ServerUtil.shared.getLectureDetail(self, parameters: parameters) { (success, dict, message) in
            guard success, let item = dict?["lecture_class"] as? NSDictionary, let totalCount = dict?["total_count"] as? Int, let attendanceCount = dict?["attendance_count"] as? Int, let tardyCount = dict?["tardy_count"] as? Int, let absentCount = dict?["absent_count"] as? Int else {
                return
            }

            self.totalCoutLabel.text = "\(totalCount)"
            self.attendanceCountLabel.text = "\(attendanceCount)"
            self.tardyCountLabel.text = "\(tardyCount)"
            self.absentCountLabel.text = "\(absentCount)"
            self.lectureClass = LectureClassData(item)
        }
    }
    
    func getOneToOneChat() {
        let parameters = [
            "lecture_class_id": lectureClass.id!,
            "parents_id": GlobalDatas.currentUser.id!
        ] as [String:Any]
        ServerUtil.shared.postNoteOne(self, parameters: parameters) { (success, dict, message) in
            guard success, let room = dict?["note"] as? NSDictionary  else {
                return
            }
            
            let vc = ChattingViewController()
            vc.room = ChatRoomData(room)
            self.show(vc, sender: nil)
        }
    }
}
