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
            
        }
    }
    
    var alarmList = [String]() {
        didSet {
            if alarmList.isEmpty {
                alarmBtn.image = UIImage(named: "alarmIcon")
            }
            else {
                alarmBtn.image = UIImage(named: "newAlarmIcon")
            }
        }
    }

    var alarmBtn = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: #selector(showAlarmEvent))
    
    @IBOutlet weak var classTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navibarSetting()
        classTableView.delegate = self
        classTableView.dataSource = self
        classTableView.register(UINib(nibName: "TeacherHomeTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
    }
    
    func navibarSetting() {
        alarmList = []
        let myBtn = UIBarButtonItem(image: UIImage(named: "myIcon"), style: .plain, target: self, action: #selector(showSettingEvent))
        
        navigationItem.rightBarButtonItems = [alarmBtn, myBtn]
    }
    
    @objc func showAlarmEvent() {
        
    }
    
    @objc func showSettingEvent() {
        
    }
}

extension TeacherHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! TeacherHomeTableViewCell
        
        return cell
    }
    
    
}
