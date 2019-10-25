//
//  TeacherSignUpViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherSignUpViewController: UIViewController {
    
    var emailCheck = false
    var parameters: [String:Any]!
    var btnList = [UIButton]()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var checkLabel: UILabel!
    @IBOutlet weak var emialCheckLabel: UILabel!
    
    @IBOutlet weak var totalCheckBtn: UIButton!
    @IBOutlet weak var check1CheckBtn: UIButton!
    @IBOutlet weak var check2CheckBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnList = [check1CheckBtn, check2CheckBtn]
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func emailCheckEvent() {
        emailDupleCheck()
    }
    
    @IBAction func signUpEvent() {
        signUp()
    }
    
    @IBAction func editTextFieldEvent(_ sender: UITextField) {
        if sender == emailTextField {
            emailCheck = false
            emialCheckLabel.isHidden = true
        }
        
        if sender == passwordTextField || sender == passwordCheckTextField {
            if passwordCheckTextField.text == passwordTextField.text {
                checkLabel.isHidden = true
            }
            else {
                checkLabel.isHidden = false
            }
        }
    }
    
    @IBAction func termCheckEvent(_ sender: UIButton) {
        if sender == totalCheckBtn {
            if sender.tag == 0 {
                sender.setImage(UIImage(named: "checkIcon"), for: .normal)
                sender.tag = 1
                sender.layer.borderColor = UIColor.greenishTeal.cgColor
                btnList.forEach {
                    $0.setImage(UIImage(named: "checkIcon"), for: .normal)
                    $0.tag = 1
                    $0.layer.borderColor = UIColor.greenishTeal.cgColor
                }
            }
            else {
                sender.setImage(nil, for: .normal)
                sender.tag = 0
                sender.layer.borderColor = UIColor.brownGrey.cgColor
                btnList.forEach {
                    $0.setImage(nil, for: .normal)
                    $0.tag = 0
                    $0.layer.borderColor = UIColor.brownGrey.cgColor
                }
            }
        }
        else {
            if sender.tag == 0 {
                sender.setImage(UIImage(named: "checkIcon"), for: .normal)
                sender.tag = 1
                sender.layer.borderColor = UIColor.greenishTeal.cgColor
            }
            else {
                sender.setImage(nil, for: .normal)
                sender.tag = 0
                sender.layer.borderColor = UIColor.brownGrey.cgColor
            }
            
            if btnList.contains(where: {$0.tag == 0}) {
                totalCheckBtn.setImage(nil, for: .normal)
                totalCheckBtn.tag = 0
                totalCheckBtn.layer.borderColor = UIColor.brownGrey.cgColor
            }
            else {
                totalCheckBtn.setImage(UIImage(named: "checkIcon"), for: .normal)
                totalCheckBtn.tag = 1
                totalCheckBtn.layer.borderColor = UIColor.greenishTeal.cgColor
            }
        }
    }
}

extension TeacherSignUpViewController {
    func emailDupleCheck() {
        guard let email = emailTextField.text, !email.isEmpty else {
            return
        }
        parameters["email"] = email
        
        ServerUtil.shared.postTeacherEmailCheck(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            self.emailCheck = true
            self.emialCheckLabel.isHidden = false
        }
    }
    
    func signUp() {
        guard let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        guard emailCheck else {
            return
        }
        
        guard checkLabel.isHidden else {
            return
        }
        
        guard !btnList.contains(where: {$0.tag == 0}) else {
            return
        }
        
        parameters["password"] = password
        ServerUtil.shared.putAuth(self, parameters: parameters) { (success, dict, message) in
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


