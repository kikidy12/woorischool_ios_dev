//
//  DailyNoteListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/14.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class DailyNoteListViewController: UIViewController {
    
    var lectureClass: LectureClassData!
    
    var noteList = [DailyNoteData]() {
        didSet {
            if noteList.isEmpty {
                
            }
            else {
                
            }
            dailyNoteTableview.reloadData()
        }
    }
    
    @IBOutlet weak var dailyNoteTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dailyNoteTableview.delegate = self
        dailyNoteTableview.dataSource = self
        dailyNoteTableview.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        dailyNoteTableview.register(UINib(nibName: "DailyNoteTableViewCell", bundle: nil), forCellReuseIdentifier: "noteCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getDailyNoteList()
    }
}

extension DailyNoteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! DailyNoteTableViewCell
        cell.initView(noteList[indexPath.item])
        cell.deleteColuser = {
            self.deleteDailyNote(id: self.noteList[indexPath.item].lectureSchedule.id!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        
        let headerBtn = UIButton()
        headerBtn.frame.size = .init(width: headerView.frame.width - 34, height: 50)
        headerBtn.center = headerView.center
        headerBtn.setTitle("+ 알림장 올리기", for: .normal)
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.colors = [UIColor.turquoiseBlue.cgColor, UIColor.dodgerBlue.cgColor]
        gradient.frame = headerBtn.bounds
        headerBtn.layer.addSublayer(gradient)
        headerBtn.layer.cornerRadius = 5
        gradient.cornerRadius = 5
        headerBtn.bringSubviewToFront(headerBtn.titleLabel!)
        headerView.addSubview(headerBtn)
        headerBtn.addTarget(self, action: #selector(selectHeadierView(_:)), for: .touchUpInside)
        return headerView
    }
    
    @ objc func selectHeadierView(_ sender: UIButton) {
        let vc = RegistDailyNoteViewController()
        vc.scheduleList = lectureClass.scheduleList
        vc.lectureClass = lectureClass
        show(vc, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RegistDailyNoteViewController()
        vc.scheduleList = lectureClass.scheduleList
        vc.lectureClass = lectureClass
        vc.preSchedule = noteList[indexPath.item].lectureSchedule
        show(vc, sender: nil)
    }
}


extension DailyNoteListViewController {
    func getDailyNoteList() {
        let parameters = [
            "lecture_class_id": lectureClass.id!
        ] as [String: Any]
        
        ServerUtil.shared.getV2Announcement(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["announcements"] as? NSArray else {
                AlertHandler().showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            self.noteList = array.compactMap { DailyNoteData($0 as! NSDictionary) }
        }
    }
    
    func deleteDailyNote(id: Int) {
        let parameters = [
            "lecture_schedule_id": id
        ] as [String:Any]
        
        ServerUtil.shared.deleteV2Announcement(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.getDailyNoteList()
        }
    }
}
