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
            "type": "PARENTS"
        ] as[String: Any]
        
        ServerUtil.shared.postAuth(self, parameters: parameters) { (success, dict, message) in
            guard success,let array = dict?["children"] as? NSArray, let user = dict?["user"] as? NSDictionary, let token = dict?["token"] as? String else { return }
            
            GlobalDatas.currentUser = UserData(user)
            GlobalDatas.childrenList = array.compactMap { UserData($0 as! NSDictionary) }
            print("userType: ", GlobalDatas.currentUser.type.rawValue)
            UserDefs.setLastUserType(type: GlobalDatas.currentUser.type.rawValue)
            UserDefs.setUserToken(token: token)
            
            if GlobalDatas.childrenList.isEmpty {
                UserDefs.setHasChildren(false)
                let vc = RegistChildViewController()
                self.show(vc, sender: nil)
            }
            else {
                UserDefs.setHasChildren(true)
                let vc = ParentsHomeViewController()
                self.show(vc, sender: nil)
            }
        }
    }
}
