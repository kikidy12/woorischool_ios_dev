//
//  TeacherStudentAttendViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherStudentAttendViewController: UIViewController {
    
    var studentList = [UserData]() {
        didSet {
            studentTableView.reloadData()
            studentTableView.performBatchUpdates(nil) { (result) in
                if let cellHeight = self.studentTableView.visibleCells.first?.frame.height {
                    self.studentTableViewHeightConstraint.constant = cellHeight * CGFloat(integerLiteral: self.studentList.count)
                }
            }
        }
    }
    
    @IBOutlet weak var studentTableView: UITableView!
    @IBOutlet weak var studentTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        studentTableView.register(UINib(nibName: "TeacherStudentAttandTableViewCell", bundle: nil), forCellReuseIdentifier: "studentCell")
        
        studentTableView.reloadData()
        studentTableView.performBatchUpdates(nil) { (result) in
            if let cellHeight = self.studentTableView.visibleCells.first?.frame.height {
                self.studentTableViewHeightConstraint.constant = cellHeight * CGFloat(integerLiteral: 20)
            }
        }
    }
    
    
}

extension TeacherStudentAttendViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath) as! TeacherStudentAttandTableViewCell
        cell.initView(studentList[indexPath.item])
        
        cell.attendClouser = { (type, selectBtn) in
            self.setAttendence(id: self.studentList[indexPath.item].id, type: type) { (_) in
                cell.attandStackView.subviews.forEach {
                    guard let btn = $0 as? UIButton else {
                        return
                    }
                    btn.backgroundColor = .clear
                    btn.setTitleColor(.brownGrey, for: .normal)
                    btn.layer.borderWidth = 1
                }
                
                if type == .attendance {
                    selectBtn.backgroundColor = .greenishTeal
                    selectBtn.setTitleColor(.greenishTeal, for: .normal)
                    selectBtn.layer.borderWidth = 0
                }
                else if type == .tardy {
                    selectBtn.backgroundColor = .blueGrey
                    selectBtn.setTitleColor(.blueGrey, for: .normal)
                    selectBtn.layer.borderWidth = 0
                }
                else if type == .absent {
                    selectBtn.backgroundColor = .grapefruit
                    selectBtn.setTitleColor(.grapefruit, for: .normal)
                    selectBtn.layer.borderWidth = 0
                }
            }
        }
        return cell
    }
}

extension TeacherStudentAttendViewController {
    func setAttendence(id: Int, type: AttendenceType, complete: @escaping (Bool) -> ()) {
        let parameters = [
            "student_id": id,
            "type": type.rawValue
        ] as [String:Any]
        ServerUtil.shared.postPushTest(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            complete(success)
        }
    }
}
