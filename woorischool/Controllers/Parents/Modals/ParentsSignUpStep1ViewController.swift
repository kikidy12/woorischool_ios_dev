//
//  ParentsSignUpStep1ViewController.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsSignUpStep1ViewController: UIViewController {
    
    @IBOutlet weak var passwordCheckTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordCheckTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "1/2"
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
        view.bounds.origin.y = 0
    }
    
    @IBAction func nextStepEvent() {
        let vc = ParentsSignUpStep2ViewController()
        self.show(vc, sender: nil)
    }
}

extension ParentsSignUpStep1ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == passwordCheckTextField {
            view.bounds.origin.y = 100
        }
        else {
            view.bounds.origin.y = 0
        }
    }
}
