//
//  TeacherHomeViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherHomeViewController: UIViewController {
    
    var classList = [LectureClassData]() {
        didSet {
            if classList.isEmpty {
                
            }
            else {
                
            }
            classCountLabel.text = "담당 강좌 총 \(classList.count)개"
            classTableView.reloadData()
        }
    }

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classCountLabel: UILabel!
    @IBOutlet weak var classTableViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var classTableView: UITableView!
    @IBOutlet weak var notiBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        classTableView.delegate = self
        classTableView.dataSource = self
        classTableView.register(UINib(nibName: "TeacherHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "teacherHomeCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUserInfo()
    }
    
    func setUserInfo() {
        let user = GlobalDatas.currentUser
        nameLabel.text = "\(user?.name ?? "미확인") 선생님\n안녕하세요"
        var count = 0
        if !GlobalDatas.noticeList.isEmpty {
            self.notiBtn.setTitle("[공지] " + GlobalDatas.noticeList[0].title, for: .normal)
            Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
                if count < GlobalDatas.noticeList.count - 1 {
                    count += 1
                }
                else {
                    count = 0
                }
                self.notiBtn.setTitle("[공지] " + GlobalDatas.noticeList[count].title, for: .normal)
            }
        }
        
        getClassInfo()
    }
}

extension TeacherHomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            classTableViewHeightContraint.constant = cell.frame.height * CGFloat(classList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teacherHomeCell", for: indexPath) as! TeacherHomeTableViewCell
        cell.initView(classList[indexPath.item])
        
        cell.classNoteClouser = {
            let vc = DailyNoteListViewController()
            vc.lectureClass = self.classList[indexPath.item]
            self.show(vc, sender: nil)
        }
        cell.classStudentClouser = {
            let vc = TeacherStudentListViewController()
            vc.lectureClass = self.classList[indexPath.item]
            self.show(vc, sender: nil)
        }
        cell.classAttendClouser = {
            let vc = TeacherStudentAttendViewController()
            vc.lectureClass = self.classList[indexPath.item]
            self.show(vc, sender: nil)
        }
        cell.classIntroductionClouser = {
            self.navigationController?.showToast(message: "준비중인 기능입니다.", font: .systemFont(ofSize: 15))
        }
        
        return cell
    }
    
    
}

extension TeacherHomeViewController {
    
    func getClassInfo() {
            let paramterts = [
                "device_token": GlobalDatas.deviceToken,
                "os": "iOS"
            ] as [String:Any]
            
            ServerUtil.shared.getV2MeInfo(self, parameters: paramterts) { (success, dict, message) in
                guard success, let array = dict?["lecture_class"] as? NSArray else {
                    AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                    return
                }
                
                self.classList = array.compactMap { LectureClassData($0 as! NSDictionary) }
            }
        }
}
