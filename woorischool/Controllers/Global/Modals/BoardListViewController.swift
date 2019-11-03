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
    @IBOutlet weak var emoInputView: EmoInputView!
    @IBOutlet weak var boardTableView: UITableView!
    @IBOutlet weak var boardTableViewConstraintHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        boardTableView.register(UINib(nibName: "BoardListTableViewCell", bundle: nil), forCellReuseIdentifier: "boardCell")
    }

}

extension BoardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            boardTableViewConstraintHeight.constant = tableView.contentSize.height
        }
    }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ClassBoardListViewController()
        self.show(vc, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
