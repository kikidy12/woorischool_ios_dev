//
//  ParentsContractListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/27.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsContractListViewController: UIViewController {
    
    var showChatClouser: (()->())!
    
    var parentList = [UserData]()
    
    @IBOutlet weak var parentsCountLabel: UILabel!
    @IBOutlet weak var parentsTableView: UITableView!
    @IBOutlet weak var parentsTableViewHeightConstrant: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parentsTableView.register(UINib(nibName: "ParentContractTableViewCell", bundle: nil), forCellReuseIdentifier: "parentsCell")
        
        parentsTableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0.001))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        parentsTableView.reloadData()
        parentsCountLabel.text = "\(parentList.count)명의 부모님이 있습니다."
    }
}

extension ParentsContractListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "parentsCell", for: indexPath) as! ParentContractTableViewCell
        cell.phoneNumLabel.text = parentList[indexPath.item].phoneNum
        cell.callClouser = {
            self.phoneCallRequest(self.parentList[indexPath.item].phoneNum ?? "")
        }
        cell.chatClouser = {
            self.dismiss(animated: false) {
                self.showChatClouser()
            }
        }
        return cell
    }
    
    
}
