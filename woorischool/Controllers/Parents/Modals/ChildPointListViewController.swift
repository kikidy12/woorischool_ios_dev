//
//  ChildPointListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/22.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChildPointListViewController: UIViewController {
    
    var childList = [UserData]() {
        didSet {
            childTableView.reloadData()
        }
    }
    
    @IBOutlet weak var childTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "자율 수강권"
        childTableView.register(UINib(nibName: "ChildInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "childCell")
        
        childTableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: childTableView.frame.width, height: 30))
        childTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: childTableView.frame.width, height: 0.001))
        childTableView.estimatedRowHeight = 200
        childTableView.rowHeight = UITableView.automaticDimension
        getChildren()
    }

}

extension ChildPointListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath) as! ChildInfoTableViewCell
        cell.initView(childList[indexPath.item])
        
        return cell
    }
}

extension ChildPointListViewController {
    func getChildren() {
        ServerUtil.shared.getParentStudent(self) { (success, dict, message) in
            guard success, let array = dict?["children"] as? NSArray else {
                return
            }
            
            self.childList = array.compactMap { UserData($0 as! NSDictionary) }
        }
    }
}
