//
//  MyPageViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/07.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    var userType: UserType = UserType(rawValue: UserDefs.lastUserType) ?? .parents
    
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userIdLabel: UILabel!
    
    @IBOutlet weak var childrenView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userType == .parents {
            childrenView.isHidden = false
        }
        else {
            childrenView.isHidden = true
        }
    }
    
    @IBAction func showChildrenListViewEvent() {
        
    }
    
    @IBAction func showChnagePasswordViewEvent() {
        
    }
    
    @IBAction func showNotiListViewEvent() {
        
    }
    
    @IBAction func showAttractViewEvent() {
        
    }
    
    @IBAction func showTermListViewEvent() {
        
    }
    
    @IBAction func logoutEvent() {
        logout()
    }
    
    @IBAction func resignEvent() {
        
    }
}

extension MyPageViewController {
    func logout() {
        ServerUtil.shared.deleteAuth(self) { (success, dict, message) in
            guard success else {
                return
            }
            UserDefs.setUserToken(token: "")
            UIApplication.shared.keyWindow?.rootViewController = SelectUserTypeViewController()
        }
    }
}
