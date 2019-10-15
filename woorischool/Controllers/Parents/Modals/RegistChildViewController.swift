//
//  RegistChildViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/10.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistChildViewController: UIViewController {
    
    var preVC: UIViewController!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var schoolNumberTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var classNumberTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func addChildEvent() {
        registChild()
    }
}

extension RegistChildViewController {
    func registChild() {
        
        guard let name = nameTextField.text, let password = passwordTextField.text, let schoolNum = schoolNumberTextField.text, let grade = gradeTextField.text, let classNum = classNumberTextField.text, let number = numberTextField.text else {
            return
        }
        
        if name.isEmpty {
            AlertHandler.shared.showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if password.isEmpty {
            AlertHandler.shared.showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if schoolNum.isEmpty {
            AlertHandler.shared.showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if grade.isEmpty {
            AlertHandler.shared.showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if classNum.isEmpty {
            AlertHandler.shared.showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if number.isEmpty {
            AlertHandler.shared.showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        let parameters = [
            "name": name,
            "password": password,
            "school_number": schoolNum,
            "grade": grade,
            "class_number": classNum,
            "number": number
        ] as [String: Any]
        
        print(parameters)
        ServerUtil.shared.postParentStudent(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "error", okTitle: "확인")
                return
            }
            UserDefs.setHasChildren(true)
            if self.navigationController!.viewControllers.contains(where: {$0 is ParentsLoginViewController}) {
                let vc = ParentsHomeViewController()
                self.show(vc, sender: nil)
            }
            else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
