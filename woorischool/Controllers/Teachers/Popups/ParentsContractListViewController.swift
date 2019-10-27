//
//  ParentsContractListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/27.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsContractListViewController: UIViewController {
    
    var parentList = [UserData]()
    
    @IBOutlet weak var parentsCountLabel: UILabel!
    @IBOutlet weak var parentsTableView: UITableView!
    @IBOutlet weak var parentsTableViewHeightConstrant: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentsTableView.register(UINib(nibName: "ParentContractTableViewCell", bundle: nil), forCellReuseIdentifier: "parentsCell")
        
        parentsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
    }

}

extension ParentsContractListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            parentsTableViewHeightConstrant.constant = cell.frame.height * CGFloat(5)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentsCell", for: indexPath) as! ParentContractTableViewCell
        
        return cell
    }
    
    
}
