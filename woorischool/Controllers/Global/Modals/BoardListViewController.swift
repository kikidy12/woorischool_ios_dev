//
//  BoardListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardListViewController: UIViewController {
    
    var boardList = [String]() {
        didSet {
            
        }
    }
    
    @IBOutlet weak var boardTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        boardTableView.contentInset = UIEdgeInsets(top: 32, left: 0, bottom: 0, right: 0)
        boardTableView.register(UINib(nibName: "BoardListTableViewCell", bundle: nil), forCellReuseIdentifier: "boardCell")
    }

}

extension BoardListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as! BoardListTableViewCell
        if indexPath.item % 2 == 0 {
            cell.userCountLabel.text = "2명"
        }
        else {
            cell.userCountLabel.text = "1명"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 35))
        titleView.backgroundColor = .clear
        let label = UILabel()
        label.frame.origin = CGPoint(x: 20, y: 0)
        label.font = UIFont(name: "NotoSansCJKkr-Medium", size: 18.0)!
        label.textColor = .greyishBrown
        label.text = "게시판 목록"
        label.frame.size = label.sizeThatFits(CGSize(width: titleView.frame.width, height: .greatestFiniteMagnitude))
        titleView.addSubview(label)
        
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ClassBoardListViewController()
        self.show(vc, sender: nil)
    }
}
