//
//  TeacherStudentAttendViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherStudentAttendViewController: UIViewController {
    
    var lectureClass: LectureClassData!
    var selectedSchedule: LectureScheduleData! {
        didSet {
            dateBarItem.title = selectedSchedule.date.dateToString(formatter: "MM/dd")
            startBtn.isEnabled = true
            endBtn.isEnabled = true
            if selectedSchedule.endTime != nil, selectedSchedule.startTime != nil {
                startBtn.setTitle(selectedSchedule.startTime.dateToString(formatter: "HH:mm"), for: .normal)
                startBtn.setTitleColor(.brownGrey, for: .normal)
                startBtn.layer.borderColor = UIColor.veryLightPink.cgColor
                startBtn.isEnabled = false
                
                endBtn.setTitle(selectedSchedule.endTime!.dateToString(formatter: "HH:mm"), for: .normal)
                endBtn.setTitleColor(.brownGrey, for: .normal)
                endBtn.layer.borderColor = UIColor.veryLightPink.cgColor
                endBtn.isEnabled = false
            }
            else if selectedSchedule.startTime != nil, selectedSchedule.endTime == nil {
                startBtn.setTitle(selectedSchedule.startTime.dateToString(formatter: "HH:mm"), for: .normal)
                startBtn.setTitleColor(.brownGrey, for: .normal)
                startBtn.layer.borderColor = UIColor.veryLightPink.cgColor
                startBtn.isEnabled = false
                
                endBtn.setTitle("수업완료", for: .normal)
                endBtn.setTitleColor(.greenishTeal, for: .normal)
                endBtn.layer.borderColor = UIColor.greenishTeal.cgColor
            }
            else if selectedSchedule.startTime == nil, selectedSchedule.endTime == nil {
                startBtn.setTitle("수업시작", for: .normal)
                startBtn.setTitleColor(.greenishTeal, for: .normal)
                startBtn.layer.borderColor = UIColor.greenishTeal.cgColor
                
                endBtn.setTitle("수업완료", for: .normal)
                endBtn.setTitleColor(.brownGrey, for: .normal)
                endBtn.layer.borderColor = UIColor.veryLightPink.cgColor
                endBtn.isEnabled = false
            }
        }
    }
    
    var studentList = [UserData]() {
        didSet {
            studentCountLabel.text = "총 \(studentList.count) 수강생"
            studentTableView.reloadData()
            studentTableView.layoutIfNeeded()
            studentTableViewHeightConstraint.constant = self.studentTableView.contentSize.height
//            studentTableView.performBatchUpdates(nil) { (result) in
//                if let cellHeight = self.studentTableView.visibleCells.first?.frame.height {
//                    self.studentTableViewHeightConstraint.constant = cellHeight * CGFloat(integerLiteral: 20)
//                }
//            }
        }
    }
    
    var dateBarItem = UIBarButtonItem()
    
    var datePickerView = UIPickerView()
    var dateToolBar = UIToolbar()
    let textFiled = UITextField(frame: .zero)
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var endBtn: UIButton!
    @IBOutlet weak var mainHeaderView: UIView!
    @IBOutlet weak var bottomScrollView: UIScrollView!
    @IBOutlet weak var classTimeLabel: UILabel!
    @IBOutlet weak var studentCountLabel: UILabel!
    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var studentTableViewHeightConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        classTimeLabel.text = lectureClass.classTime
        bottomScrollView.delegate = self
        studentTableView.register(UINib(nibName: "TeacherStudentAttandTableViewCell", bundle: nil), forCellReuseIdentifier: "studentCell")
        settingNaviItems()
        settingPickerView()
        
        let tempList = lectureClass.scheduleList.filter({
            $0.date.dateToString(formatter: "yyyy-MM-dd") >= Date().dateToString(formatter: "yyyy-MM-dd")
        })
        
        if tempList.isEmpty {
            getClassInfo(id: lectureClass.scheduleList.last!.id)
        }
        else {
            getClassInfo(id: tempList.first!.id)
        }
    }
    
    override func viewWillLayoutSubviews() {
        studentTableView.layoutIfNeeded()
        studentTableViewHeightConstraint.constant = self.studentTableView.contentSize.height
    }
    
    func settingNaviItems() {
        dateBarItem = UIBarButtonItem(title: "날짜", style: .plain, target: self, action: #selector(selectedDate))
        navigationItem.rightBarButtonItem = dateBarItem
        title = "\(lectureClass.lecture?.name ?? "강좌") \(lectureClass.name ?? "클래스")"
    }
    
    
    func settingPickerView() {
        dateToolBar.sizeToFit()
        let selectBtn = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectEvnet))
        let closeBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeEvnet))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)

        dateToolBar.items = [closeBtn, space, selectBtn]
        textFiled.inputAccessoryView = dateToolBar
        textFiled.inputView = datePickerView

        datePickerView.delegate = self
        datePickerView.dataSource = self
        
        self.view.addSubview(textFiled)
    }

    @objc func selectEvnet() {
        selectedSchedule = lectureClass.scheduleList[datePickerView.selectedRow(inComponent: 0)]
        getClassInfo(id: lectureClass.scheduleList[datePickerView.selectedRow(inComponent: 0)].id)
        textFiled.resignFirstResponder()
    }
    
    @objc func selectedDate() {
        textFiled.becomeFirstResponder()
    }

    @objc func closeEvnet() {
        textFiled.resignFirstResponder()
    }
    
    @IBAction func selectStartEndEvnet(_ sender: UIButton) {
        if sender.tag == 0 {
            startAndEndClass(status:"START")
        }
        else {
            startAndEndClass(status: "END")
        }
    }
}
extension TeacherStudentAttendViewController: UIScrollViewDelegate {
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView == bottomScrollView {
//            let magicalSafeAreatops: CGFloat = mainHeaderView.frame.height * 2
//            let offset = magicalSafeAreatops * (scrollView.contentOffset.y / scrollView.contentSize.height)
//            print(offset)
//            mainHeaderView.transform = .init(translationX: 0, y: min(0, -offset))
//        }
//    }
}

extension TeacherStudentAttendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! TeacherStudentAttandTableViewCell
        cell.initView(studentList[indexPath.item])
        
        cell.attendClouser = { (type, selectBtn) in
            self.setAttendence(id: self.studentList[indexPath.item].id, type: type) { (_) in
                cell.setAttendBtns(type)
            }
        }
        return cell
    }
}

extension TeacherStudentAttendViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return lectureClass.scheduleList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return lectureClass.scheduleList[row].date.dateToString(formatter: "MM월 dd일")
    }
    
}

extension TeacherStudentAttendViewController {
    func setAttendence(id: Int, type: AttendenceType, complete: @escaping (Bool) -> ()) {
        let parameters = [
            "lecture_schedule_id": selectedSchedule.id!,
            "student_id": id,
            "status": type.rawValue
        ] as [String:Any]
        ServerUtil.shared.postLectureSchedule(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler().showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            complete(success)
        }
    }
    
    
    func getClassInfo (id: Int) {
        let parameters = [
            "lecture_schedule_id": id
        ] as [String: Any]
        ServerUtil.shared.getLectureSchedule(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["users"] as? NSArray, let schedule = dict?["lecture_schedule"] as? NSDictionary else {
                return
            }
            
            self.studentList = array.compactMap { UserData($0 as! NSDictionary) }
            self.selectedSchedule = LectureScheduleData(schedule)
        }
    }
    
    func startAndEndClass(status: String) {
        let parameters = [
            "lecture_schedule_id": selectedSchedule.id!,
            "status": status
        ] as [String:Any]
        
        ServerUtil.shared.postLectureStatus(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["users"] as? NSArray, let schedule = dict?["lecture_schedule"] as? NSDictionary else {
                AlertHandler().showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            self.studentList = array.compactMap { UserData($0 as! NSDictionary) }
            self.selectedSchedule = LectureScheduleData(schedule)
        }
    }
}
