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
            alarmEmptyView.isHidden = alarmList.isEmpty ? false : true
            alarmTableView.reloadData()
        }
    }
    
    @IBOutlet weak var alarmTableView: UITableView!
    @IBOutlet weak var alarmEmptyView: UIView!


    override func viewDidLoad() {
        super.viewDidLoad()
        title = "알림"
        alarmTableView.register(UINib(nibName: "AlarmTableViewCell", bundle: nil), forCellReuseIdentifier: "alarmCell")
        alarmTableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0.001, height: 20))
        alarmTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0.001, height: 0.001))
        alarmTableView.estimatedRowHeight = 100
        alarmTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getAlarmList()
    }

}

extension AlarmListViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as! AlarmTableViewCell
        
        cell.initView(alarmList[indexPath.item])
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = self.view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + height
        
        navigationController!.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let height = self.view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + height
        if offset > 0 {
            navigationController!.setNavigationBarHidden(true, animated: true)
        }
        else if offset <= 0 {
            navigationController!.setNavigationBarHidden(false, animated: true)
        }
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
