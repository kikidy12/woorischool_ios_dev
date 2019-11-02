//
//  DailyNotiViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class DailyNotiViewController: UIViewController {
    
    @IBOutlet weak var dailyTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        dailyTableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        dailyTableView.register(UINib(nibName: "ClassBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "boardCell")
    }
}

extension DailyNotiViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as! ClassBoardTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35))
        titleView.backgroundColor = .clear
        let label = UILabel()
        label.frame.origin = CGPoint(x: 20, y: 0)
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 18.0)!
        label.textColor = .greyishBrown
        label.text = "수업 목록"
        label.frame.size = label.sizeThatFits(CGSize(width: titleView.frame.width, height: .greatestFiniteMagnitude))
        titleView.addSubview(label)
        
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
