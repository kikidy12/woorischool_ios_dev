//
//  RegistedClassMainViewController.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistedClassMainViewController: UIViewController {
    
    @IBOutlet weak var headerFirstView: UIView!
    @IBOutlet weak var headerSecondView: UIView!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var classTabelView: UITableView!
    @IBOutlet weak var classTableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classTabelView.delegate = self
        classTabelView.dataSource = self
        
        classTabelView.register(UINib(nibName: "RegistedClassTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        
        let attributedString = NSMutableAttributedString(string: "12:00 시간 이내에 수강확정이 되지 않으면 \n다음 대기자에게 수강신청 권한이 넘어갑니다", attributes: [
            .font: UIFont(name: "NotoSansCJKkr-Regular", size: 14.0)!,
            .foregroundColor: UIColor.grapefruit,
            .kern: 0.0
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "NotoSansCJKkr-Medium", size: 14.0)!, range: NSRange(location: 0, length: 5))

        alertLabel.attributedText = attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "신청현황"
    }


    @IBAction func selectHeader(_ sender: UIButton) {
        if sender.superview == headerFirstView {
            if let lineView = headerFirstView.subviews.last {
                sender.setTitleColor(.greyishBrown, for: .normal)
                lineView.backgroundColor = .greyishBrown
            }
            if let lineView = headerSecondView.subviews.last, let btn = headerSecondView.subviews.first as? UIButton {
                btn.setTitleColor(.brownGrey, for: .normal)
                lineView.backgroundColor = .clear
            }
            
        }
        if sender.superview == headerSecondView {
            if let lineView = headerSecondView.subviews.last {
                sender.setTitleColor(.greyishBrown, for: .normal)
                lineView.backgroundColor = .greyishBrown
            }
            if let lineView = headerFirstView.subviews.last, let btn = headerFirstView.subviews.first as? UIButton {
                btn.setTitleColor(.brownGrey, for: .normal)
                lineView.backgroundColor = .clear
            }
            
        }
    }

}

extension RegistedClassMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RegistedClassTableViewCell {
            cell.initView(indexPath.item % 2 == 0)
        }
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            classTableViewHeightConstraint.constant = tableView.contentSize.height
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! RegistedClassTableViewCell
        
        return cell
    }
    
    
}
