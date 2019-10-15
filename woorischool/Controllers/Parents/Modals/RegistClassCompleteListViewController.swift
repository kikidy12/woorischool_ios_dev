//
//  RegistClassCompleteListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/15.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit


class RegistClassCompleteListViewController: UIViewController {
    
    var lectureClassList = [LectureClassData]() {
        didSet {
            if lectureClassList.isEmpty {
                
            }
            else {
                
            }
            totalCountLabel.text = "총 \(lectureClassList.count) 강좌"
            compRegistTableView.reloadData()
        }
    }
    
    @IBOutlet weak var totalCountLabel: UILabel!

    @IBOutlet weak var compRegistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "수강확정"
        
        compRegistTableView.delegate = self
        compRegistTableView.dataSource = self
        
        compRegistTableView.register(UINib(nibName: "RegistCompClassTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        
        getLectureClass()
    }

}

extension RegistClassCompleteListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectureClassList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! RegistCompClassTableViewCell
        cell.initView(lectureClassList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ClassInfoPopupViewController()
        vc.lectureClass = lectureClassList[indexPath.item]
        showPopupView(vc: vc)
    }
}

extension RegistClassCompleteListViewController {
    func getLectureClass() {
        let parameters = [
            "status": "CONFIRM"
        ] as [String:Any]
        ServerUtil.shared.getLectureApply(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["lecture_class"] as? NSArray else {
                return
            }
            
            self.lectureClassList = array.compactMap { LectureClassData($0 as! NSDictionary) }
        }
    }
}

