//
//  TeacherPhoneAuthViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/25.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherPhoneAuthViewController: UIViewController {
    
    var parameters = [String:Any]()
    
    var isPhoneAhthClick = false
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var authCodeTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextEvent() {
        authNumCheck()
    }
    
    @IBAction func sendCodeEvnet() {
        sendPhoneAuthCode()
    }
}


extension TeacherPhoneAuthViewController {
    func sendPhoneAuthCode() {
        guard let phoneNum = phoneNumTextField.text, !phoneNum.isEmpty, let name = nameTextField.text, !name.isEmpty else {
            return
        }
        
        parameters["phone_num"] = phoneNum
        parameters["name"] = name
        
        ServerUtil.shared.postTeacherPhoneAuth(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "ServerError", okTitle: "확인")
                return
            }
            
            self.isPhoneAhthClick = true
        }
    }
    
    func authNumCheck() {
        guard isPhoneAhthClick else {
            return
        }
        
        guard let code = authCodeTextField.text, !code.isEmpty else {
            return
        }
        
        parameters["phone_auth_num"] = code
        
        ServerUtil.shared.postPhoneAuthNumCheck(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "ServerError", okTitle: "확인")
                return
            }
            
            let vc = TeacherSignUpViewController()
            vc.parameters = self.parameters
            self.show(vc, sender: nil)
        }
    }
}
