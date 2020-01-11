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
    
    @IBOutlet weak var changePasswordView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if userType == .parents {
            changePasswordView.isHidden = true
        }
        else {
            changePasswordView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "더보기"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    @IBAction func showChnagePasswordViewEvent() {
        let vc = ChangePasswordViewController()
        self.show(vc, sender: nil)
    }
    
    
    @IBAction func showTermListViewEvent() {
        AlertHandler().showAlert(vc: self, message: "준비중인 기능입니다.", okTitle: "확인")
    }
    
    
    @IBAction func logoutEvent() {
        AlertHandler().showAlert(vc: self, message: "로그아웃 하시겠습니까", okTitle: "로그아웃", cancelTitle: "취소", okHandler: { (_) in
            self.logout()
        })
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
            let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
            navi.navigationBar.tintColor = .black
            navi.navigationBar.barTintColor = .white
            navi.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow?.rootViewController = navi
        }
    }
}
