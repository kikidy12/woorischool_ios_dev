//
//  LikeUserListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/24.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LikeUserListViewController: UIViewController {
    
    var board: BoardData!
    
    var likeUserList = [UserData]() {
        didSet {
            likeCountLabel.text = "\(likeUserList.count)+"
            likeUserTableView.reloadData()
        }
    }

    @IBOutlet weak var likeUserTableView: UITableView!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeUserTableView.register(UINib(nibName: "BoardLikeUserTableViewCell", bundle: nil), forCellReuseIdentifier: "userCell")
        getLikeUserList()
    }

}

extension LikeUserListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeUserList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! BoardLikeUserTableViewCell
        
        cell.user = likeUserList[indexPath.item]
        return cell
    }
    
    
}


extension LikeUserListViewController {
    func getLikeUserList() {
        var parameters = [String:Any]()
        if board.type == "ALL" {
            parameters["all_board_id"] = board.id!
        }
        else {
            parameters["board_id"] = board.id!
        }
        
        ServerUtil.shared.getLike(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["users"] as? NSArray else {
                return
            }
            
            self.likeUserList = array.compactMap { UserData($0 as! NSDictionary) }
        }
    }
}
