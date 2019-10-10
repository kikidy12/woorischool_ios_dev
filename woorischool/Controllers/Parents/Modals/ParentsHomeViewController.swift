//
//  ParentsHomeViewController.swift
//  woorischool
//
//  Created by 권성민 on 03/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsHomeViewController: UIViewController {
    
    @IBOutlet weak var scheduleTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navibarSetting()
        
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        
        scheduleTableView.register(UINib(nibName: "ParentsHomeScheduleTableViewCell", bundle: nil), forCellReuseIdentifier: "scheduleCell")
    }

    func navibarSetting() {
        let myBtn = UIBarButtonItem(image: UIImage(named: "filterImage"), style: .plain, target: self, action: #selector(showSettingEvent))
        
        let alarmBtn = UIBarButtonItem(image: UIImage(named: "filterImage"), style: .plain, target: self, action: #selector(showAlarmEvent))
        
        navigationItem.rightBarButtonItems = [myBtn, alarmBtn]
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
        
    }
}

extension ParentsHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ParentsHomeScheduleTableViewCell
        
        return cell
    }
    
    
}
