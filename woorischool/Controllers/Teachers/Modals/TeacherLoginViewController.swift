//
//  TeacherLoginViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherLoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func loginEvent() {
        login()
    }
    
    @IBAction func signUpEvnent() {
        show(TeacherPhoneAuthViewController(), sender: nil)
    }

}


extension TeacherLoginViewController {
    func login() {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        let parameters = [
            "email": email,
            "password": password,
            "type": "TEACHER"
        ] as [String: Any]
        
        ServerUtil.shared.postAuth(self, parameters: parameters) { (success, dict, message) in
            guard success, let token = dict?["token"] as? String else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            UserDefs.setLastUserType(type: "TEACHER")
            UserDefs.setUserToken(token: token)
            
            let navi = UINavigationController(rootViewController: TeacherMainViewController())
            navi.navigationBar.tintColor = .black
            navi.navigationBar.barTintColor = .white
            navi.navigationBar.shadowImage = UIImage()
            UIApplication.shared.keyWindow?.rootViewController = navi
        }
    }
}
