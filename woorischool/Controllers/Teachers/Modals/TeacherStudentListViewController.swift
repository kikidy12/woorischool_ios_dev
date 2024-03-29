//
//  TeacherStudentListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/27.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherStudentListViewController: UIViewController {
    
    var lectureClass: LectureClassData!
    
    var studentList = [UserData]() {
        didSet {
            if studentList.isEmpty {
                
            }
            else {
                
            }
            studentCountLabel.text = "총 \(studentList.count) 수강생"
            studentTableView.reloadData()
        }
    }
    
    @IBOutlet weak var studentCountLabel: UILabel!
    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var studentTableViewHeightConstraint: NSLayoutConstraint!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard lectureClass != nil else {
            return
        }
        
        title = "\(lectureClass.lecture.name ?? "강의명") \(lectureClass.name ?? "클래스명")"
        studentTableView.register(UINib(nibName: "StudentContactTableViewCell", bundle: nil), forCellReuseIdentifier: "studentCell")
        
        studentTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
    }

    override func viewWillAppear(_ animated: Bool) {
        getStudents()
    }
}

extension TeacherStudentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            studentTableViewHeightConstraint.constant = cell.frame.height * CGFloat(studentList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! StudentContactTableViewCell
        cell.initView(studentList[indexPath.item])
        cell.contactParentClouser = {
            let vc = ParentsContractListViewController()
            self.showPopupView(vc: vc)
        }
        return cell
    }
    
    
}

extension TeacherStudentListViewController {
    func getStudents() {
        let parameters = [
            "lecture_class_id": lectureClass.id!
        ] as [String:Any]
        ServerUtil.shared.postStudentList(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["student"] as? NSArray else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            self.studentList = array.compactMap { UserData($0 as! NSDictionary)}
        }
    }
}
