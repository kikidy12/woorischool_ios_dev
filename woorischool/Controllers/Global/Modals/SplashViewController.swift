//
//  SplashViewController.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
          }
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        print(UserDefs.lastUserType)
        print(UserDefs.hasChildren)
        if UserDefs.userToken != "" {
            let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
            navi.navigationBar.tintColor = .black
            navi.navigationBar.barTintColor = .white
            navi.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow?.rootViewController = navi
//            if UserDefs.lastUserType == UserType.parents.rawValue, UserDefs.hasChildren {
//                let navi = UINavigationController(rootViewController: ParentsHomeViewController())
//                navi.navigationBar.tintColor = .black
//                navi.navigationBar.barTintColor = .white
//                navi.navigationBar.shadowImage = UIImage()
//                UIApplication.shared.keyWindow?.rootViewController = navi
//            }
//            else if UserDefs.lastUserType == UserType.teacher.rawValue {
//
//            }
//            else if UserDefs.lastUserType == UserType.student.rawValue {
//
//            }
//            else {
//                UIApplication.shared.keyWindow?.rootViewController = SelectUserTypeViewController()
//            }
            
        }
        else {
            let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
            navi.navigationBar.tintColor = .black
            navi.navigationBar.barTintColor = .white
            navi.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow?.rootViewController = navi
        }
    }
}
