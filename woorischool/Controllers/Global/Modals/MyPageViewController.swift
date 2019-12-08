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
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBOutlet weak var childrenView: UIView!
    @IBOutlet weak var quaterClassListView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        userNameLabel.text = GlobalDatas.currentUser.name
        if userType == .parents {
            userTypeLabel.isHidden = true
            userInfoLabel.text = GlobalDatas.currentUser.phoneNum
        }
        else {
            childrenView.isHidden = true
            quaterClassListView.isHidden = true
            userTypeLabel.text = "선생님"
            userInfoLabel.text = GlobalDatas.currentUser.email
        }
    }
    
    @IBAction func showMyBoardListEvent() {
        let vc = ClassBoardListViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showChildrenListViewEvent() {
        let vc = ManageChildrenViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showMyQuaterClassListEvent() {
        let vc = QuarterClassListViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showChnagePasswordViewEvent() {
        
    }
    
    @IBAction func showNotiListViewEvent() {
        let vc = NotiListViewController()
        show(vc, sender: nil)
    }
    
    @IBAction func showAttractViewEvent() {
        
    }
    
    @IBAction func showTermListViewEvent() {
        
    }
    
    @IBAction func logoutEvent() {
        AlertHandler.shared.showAlert(vc: self, message: "로그아웃 하시겠습니까", okTitle: "로그아웃", cancelTitle: "취소", okHandler: { (_) in
            self.logout()
        })
    }
    
    @IBAction func resignEvent() {
        
    }
    
    func settingMeInfo() {
        
    }
}

extension MyPageViewController {
    func logout() {
        ServerUtil.shared.deleteAuth(self) { (success, dict, message) in
            guard success else {
                return
            }
            UserDefs.setUserToken(token: "")
            let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
            navi.navigationBar.tintColor = .black
            navi.navigationBar.barTintColor = .white
            navi.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow?.rootViewController = navi
        }
    }
}
