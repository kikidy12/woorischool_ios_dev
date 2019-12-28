//
//  NotiDetailViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/28.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class NotiDetailViewController: UIViewController {
    
    var noti: NoticeData!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = noti.title
        timeLabel.text = noti.cretedAt.dateToString(formatter: "MM/dd HH:mm")
        contentLabel.text = noti.content
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "공지사항"
    }
}
