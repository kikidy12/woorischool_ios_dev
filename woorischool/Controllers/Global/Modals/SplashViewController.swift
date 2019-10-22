//
//  SplashViewController.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewDidAppear(_ animated: Bool) {
        print(UserDefs.lastUserType)
        print(UserDefs.hasChildren)
        if UserDefs.userToken != "" {
//            let vc = SelectUserTypeViewController()
//            vc.modalPresentationStyle = .fullScreen
//            self.present(vc, animated: true, completion: nil)
            if UserDefs.lastUserType == UserType.parents.rawValue, UserDefs.hasChildren {
                let navi = UINavigationController(rootViewController: ParentsHomeViewController())
                navi.navigationBar.tintColor = .black
                navi.navigationBar.barTintColor = .white
                navi.modalPresentationStyle = .fullScreen
                navi.navigationBar.shadowImage = UIImage()
                self.present(navi, animated: true, completion: nil)
            }
            else if UserDefs.lastUserType == UserType.teacher.rawValue {

            }
            else if UserDefs.lastUserType == UserType.student.rawValue {

            }
            else {
                let vc = SelectUserTypeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            
        }
        else {
            let vc = SelectUserTypeViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
}
