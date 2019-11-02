//
//  ClassBoardListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ClassBoardListViewController: UIViewController {
    
    @IBOutlet weak var boardTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardTableView.register(UINib(nibName: "ClassBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "boardCell")
        
        boardTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
}

extension ClassBoardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as! ClassBoardTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BoardDetailViewController()
        self.show(vc, sender: nil)
    }
}
