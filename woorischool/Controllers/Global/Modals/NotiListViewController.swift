//
//  NotiListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class NotiListViewController: UIViewController {
    
    var notiList = [String]()
    
    @IBOutlet weak var notiTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notiTableView.register(UINib(nibName: "NotiTableViewCell", bundle: nil), forCellReuseIdentifier: "notiCell")
        notiTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
    }

}


extension NotiListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notiCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
}
