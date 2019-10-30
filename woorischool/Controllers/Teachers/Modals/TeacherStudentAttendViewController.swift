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
        
        return cell
    }
}
