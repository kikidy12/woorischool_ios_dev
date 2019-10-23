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
//            UIApplication.shared.keyWindow?.rootViewController = SelectUserTypeViewController()
            if UserDefs.lastUserType == UserType.parents.rawValue, UserDefs.hasChildren {
                let navi = UINavigationController(rootViewController: ParentsHomeViewController())
                navi.navigationBar.tintColor = .black
                navi.navigationBar.barTintColor = .white
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
            }
            else if UserDefs.lastUserType == UserType.teacher.rawValue {
                let vc = SelectUserTypeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            else if UserDefs.lastUserType == UserType.student.rawValue {
                let vc = SelectUserTypeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            else {
                UIApplication.shared.keyWindow?.rootViewController = SelectUserTypeViewController()
            }
            
        }
        else {
            UIApplication.shared.keyWindow?.rootViewController = SelectUserTypeViewController()
        }
    }
}
