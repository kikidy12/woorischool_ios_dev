//
//  ChangePasswordViewController.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/08.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var currentPwTextField: UITextField!
    @IBOutlet weak var newPwTextField: UITextField!
    @IBOutlet weak var newPwCheckTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "비밀번호 변경"
        let uploadBtn = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(changePwEvent))
        
        uploadBtn.tintColor = .greenishTeal
        
        navigationItem.rightBarButtonItem = uploadBtn
    }
    
    @objc func changePwEvent() {
        guard let currentPw = currentPwTextField.text, let newPw = newPwTextField.text, let checkPw = newPwCheckTextField.text else {
            return
        }
        
        if currentPw.isEmpty, newPw.isEmpty, checkPw.isEmpty {
            AlertHandler().showAlert(vc: self, message: "빈 입력이 있습니다.", okTitle: "확인")
            return
        }
        
        if newPw != checkPw {
            AlertHandler().showAlert(vc: self, message: "비밀번호가 일치하지 않습니다.", okTitle: "확인")
            return
        }
        
        let parameters = [
            "password": currentPw,
            "new_password": newPw
        ] as [String:Any]
        
        ServerUtil.shared.postPasswordChange(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler().showAlert(vc: self, message: message ?? "Server error", okTitle: "확인")
                return
            }
            self.navigationController?.showToast(message: "비밀번호 변경 완료", font: UIFont.systemFont(ofSize: 15))
            self.navigationController?.popViewController(animated: true)
        }
        
    }
}
