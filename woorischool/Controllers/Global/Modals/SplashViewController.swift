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
        
        if #available(iOS 13.0, *) {
            
        }
        else {
            AlertHandler().showAlert(vc: self, message: "ios 13버전 이후만 사용 가능합니다.", okTitle: "확인", okHandler: { (_) in
                exit(0)
            })
        }
        
        if UIDevice.modelName.contains("SE") {
            AlertHandler().showAlert(vc: self, message: "se모델은 지원하지 않습니다.", okTitle: "확인", okHandler: { (_) in
                exit(0)
            })
        }
        
        print("x-http-token: ", UserDefs.userToken)
        if UserDefs.userToken != "" {
            getInfo {
                if UserDefs.lastUserType == UserType.parents.rawValue, UserDefs.hasChildren, let name = GlobalDatas.currentUser.name, !name.isEmpty {
                    let navi = UINavigationController(rootViewController: ParentsMainViewController())
                    navi.navigationBar.tintColor = .black
                    navi.navigationBar.barTintColor = .white
                    navi.navigationBar.shadowImage = UIImage()
                    UIApplication.shared.keyWindow?.rootViewController = navi
                }
                else if UserDefs.lastUserType == UserType.teacher.rawValue {
                    let navi = UINavigationController(rootViewController: TeacherMainViewController())
                    navi.navigationBar.tintColor = .black
                    navi.navigationBar.barTintColor = .white
                    navi.navigationBar.shadowImage = UIImage()
                    UIApplication.shared.keyWindow?.rootViewController = navi
                }
                else if UserDefs.lastUserType == UserType.student.rawValue {
                    let navi = UINavigationController(rootViewController: StudentMainViewController())
                    navi.navigationBar.tintColor = .black
                    navi.navigationBar.barTintColor = .white
                    navi.navigationBar.shadowImage = UIImage()
                    UIApplication.shared.keyWindow?.rootViewController = navi
                }
                else {
                    if UserDefs.isOpenedApp {
                        let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
                        navi.navigationBar.tintColor = .black
                        navi.navigationBar.barTintColor = .white
                        navi.navigationBar.shadowImage = UIImage()
                        UIApplication.shared.keyWindow?.rootViewController = navi
                    }
                    else {
                        UIApplication.shared.keyWindow?.rootViewController = TutoViewController()
                    }
                }
            }
        }
        else {
            if UserDefs.isOpenedApp {
                let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
                navi.navigationBar.tintColor = .black
                navi.navigationBar.barTintColor = .white
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
            }
            else {
                UIApplication.shared.keyWindow?.rootViewController = TutoViewController()
            }
        }
    }
}

extension SplashViewController {
    func getInfo(complete: @escaping ()->()) {
        let parameters = [
            "device_token": GlobalDatas.deviceToken,
            "os": "iOS"
        ] as [String:Any]
        
        ServerUtil.shared.getV2Info(self, parameters: parameters) { (success, dict, message) in
            guard success, let user = dict?["user"] as? NSDictionary else {
                if UserDefs.isOpenedApp {
                    let navi = UINavigationController(rootViewController: SelectUserTypeViewController())
                    navi.navigationBar.tintColor = .black
                    navi.navigationBar.barTintColor = .white
                    navi.navigationBar.shadowImage = UIImage()
                    UIApplication.shared.keyWindow?.rootViewController = navi
                }
                else {
                    UIApplication.shared.keyWindow?.rootViewController = TutoViewController()
                }
                
                return
            }
            
            GlobalDatas.currentUser = UserData(user)
            UserDefs.setLastUserType(type: GlobalDatas.currentUser.type.rawValue)
            complete()
        }
    }
}
