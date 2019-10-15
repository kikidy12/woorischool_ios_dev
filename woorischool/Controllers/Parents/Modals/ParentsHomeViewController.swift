//
//  ParentsHomeViewController.swift
//  woorischool
//
//  Created by 권성민 on 03/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsHomeViewController: UIViewController {
    
    var lectureList = [LectureClassDayData]() {
        didSet {
            if lectureList.isEmpty {
                
            }
            else {
                
            }
            
            scheduleTableView.reloadData()
        }
    }
    
    var selectDate = Date()
    var selectedNumber = 1
    
    var selectDateStr: String {
        selectDate = Calendar.current.date(byAdding: .day, value: selectedNumber, to: Date().startOfWeek!.addingTimeInterval(-3600))!
        
        selectDayLabel.text = dateformatter.string(from: selectDate) + "일 일정"
        return dateformatter.string(from: selectDate)
    }
    
    let dateformatter = DateFormatter()
    let dayformatter = DateFormatter()
    
    @IBOutlet weak var childProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectDayLabel: UILabel!
    @IBOutlet weak var dateStackView: UIStackView!
    @IBOutlet weak var scheduleTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.viewControllers.removeAll(where: {$0 is RegistChildViewController})

        navibarSetting()
        
        dateformatter.dateFormat = "yyyy-MM-dd"
        dayformatter.dateFormat = "dd"
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        scheduleTableView.register(UINib(nibName: "ParentsHomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dateStackViewSetting()
        getInfo(dateStr: dateformatter.string(from: selectDate))
    }

    func navibarSetting() {
        let myBtn = UIBarButtonItem(image: UIImage(named: "myIcon"), style: .plain, target: self, action: #selector(showSettingEvent))
        
        let alarmBtn = UIBarButtonItem(image: UIImage(named: "alarmIcon"), style: .plain, target: self, action: #selector(showAlarmEvent))
        
        navigationItem.rightBarButtonItems = [alarmBtn, myBtn]
    }
    
    @objc func showAlarmEvent() {
        
    }
    
    @objc func showSettingEvent() {
        
    }
    
    @IBAction func showRegistViewEvent() {
        let vc = CourseRegistrationViewController()
        self.show(vc, sender: nil)
    }

    @IBAction func showRegistedClassViewEvent() {
        let vc = RegistedClassMainViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showCompleteRegistViewEvent() {
        let vc = ClassRegistCompleteListViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func selectDateEvent(_ sender: UIButton) {
        selectedNumber = sender.tag
        getInfo(dateStr: selectDateStr)
        dateStackViewSetting()
    }
    
    func setUserInfo() {
        let user = GlobalDatas.currentUser
        
        nameLabel.text = "\(user?.childlen?.name ?? "아무개") 학부모님\n안녕하세요"
        
    }
    
    func dateStackViewSetting() {
        dateStackView.arrangedSubviews.enumerated().forEach {
            if let btn = $0.element as? UIButton {
                let date = Calendar.current.date(byAdding: .day, value: $0.offset, to: Date().startOfWeek!.addingTimeInterval(-3600))!
                let dateStr = dayformatter.string(from: date)
                let selectStr = dayformatter.string(from: selectDate)
                
                if dateStr == selectStr {
                    btn.layer.borderWidth = 1
                    btn.setTitleColor(.greenishTeal, for: .normal)
                }
                else {
                    btn.layer.borderWidth = 0
                    btn.setTitleColor(.greyishBrown, for: .normal)
                }
                
                btn.setTitle(dateStr, for: .normal)
            }
        }
    }
}

extension ParentsHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ParentsHomeScheduleTableViewCell
        cell.initView(lectureList[indexPath.item])
        return cell
    }
    
    
}

extension ParentsHomeViewController {
    func getInfo(dateStr: String) {
        let parameters = [
            "date": dateStr,
            "device_token": GlobalDatas.deviceToken,
            "os": "iOS"
        ] as [String:Any]
        print(UserDefs.userToken)
        print(parameters)
        ServerUtil.shared.getMeInfo(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["lecture_list"] as? NSArray, let user = dict?["user"] as? NSDictionary else {
                return
            }
            
            GlobalDatas.currentUser = UserData(user)
            UserDefs.setHasChildren(true)
            UserDefs.setLastUserType(type: UserType.parents.rawValue)
            self.lectureList = array.compactMap { LectureClassDayData($0 as! NSDictionary) }
            self.setUserInfo()
            
        }
    }
}
