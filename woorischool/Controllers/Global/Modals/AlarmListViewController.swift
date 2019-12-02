//
//  AlarmListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController {
    
    var alarmList = [AlarmData]() {
        didSet {
            if alarmList.isEmpty {
                
            }
            else {
                alarmTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var alarmTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        alarmTableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "alarmCell")
        
        alarmTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0.001, height: 0.001))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAlarmList()
    }

}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmTableViewCell
        cell.initView(alarmList[indexPath.item])
        return cell
    }
    
    
}

extension AlarmListViewController {
    func getAlarmList() {
        ServerUtil.shared.getNotification(self) { (success, dict, message) in
            guard success, let array = dict?["notifications"] as? NSArray else {
                return
            }
            
            self.alarmList = array.compactMap { AlarmData(data: $0 as! NSDictionary) }
        }
    }
}
