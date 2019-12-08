//
//  QuarterClassListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/04.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class QuarterClassListViewController: UIViewController {
    
    var quaterList = [QuaterData]() {
        didSet {
            if quaterList.isEmpty {
                
            }
            else {
                quaterClassTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var quaterClassTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        quaterClassTableView.register(UINib(nibName: "MyClassRecordTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        
        getQuaterClassList()
        
        title = "수강이력"
    }
}


extension QuarterClassListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return quaterList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quaterList[section].lectureClassList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! MyClassRecordTableViewCell
        cell.initView(quaterList[indexPath.section].lectureClassList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = MyRegistCourseHeaderView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 60))
        headerView.initView(quaterList[section])
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 13))
        footerView.backgroundColor = .veryLightPink
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 13
    }
}


extension QuarterClassListViewController {
    func getQuaterClassList() {
        ServerUtil.shared.getLectureHistory(self) { (success, dict, message) in
            guard success, let array = dict?["lecture_history"] as? NSArray else {
                return
            }
            
            self.quaterList = array.compactMap { QuaterData($0 as! NSDictionary) }
        }
    }
}
