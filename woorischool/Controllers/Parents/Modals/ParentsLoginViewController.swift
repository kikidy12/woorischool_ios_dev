//
//  ParentsLoginViewController.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsLoginViewController: UIViewController {
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func SMSAuthEvent() {
        smsAuth()
    }
    
    @IBAction func loginEvent() {
        login()
    }
}

extension ParentsLoginViewController {
    func smsAuth() {
        let parameters = [
            "phone_num": phoneNumTextField.text!,
            "os": "iOS",
            "device_token": GlobalDatas.deviceToken
        ] as[String: Any]
        print(parameters)
        ServerUtil.shared.postPhoneAuth(self, parameters: parameters) { (success, dict, message) in
            AlertHandler.shared.showAlert(vc: self, message: message ?? "error", okTitle: "확인")
        }
    }
    
    func login() {
        let parameters = [
            "phone_num": phoneNumTextField.text!,
            "phone_auth_num": codeTextField.text!,
            "type": UserType.parents
        ] as[String: Any]
        
        print(parameters)
        ServerUtil.shared.postAuth(self, parameters: parameters) { (success, dict, message) in
            guard success, let user = dict?["user"] as? NSDictionary, let token = dict?["token"] as? String else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            GlobalDatas.currentUser = UserData(user)
            
            UserDefs.setLastUserType(type: GlobalDatas.currentUser.type.rawValue)
            UserDefs.setUserToken(token: token)
            
            if GlobalDatas.currentUser.childlen == nil {
                UserDefs.setHasChildren(false)
                UIApplication.shared.keyWindow?.rootViewController = RegistChildViewController()
            }
            else {
                UserDefs.setHasChildren(true)
                let navi = UINavigationController(rootViewController: ParentsMainViewController())
                navi.navigationBar.tintColor = .black
                navi.navigationBar.barTintColor = .white
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
                
            }
        }
    }
}
