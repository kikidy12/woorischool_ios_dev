//
//  TeacherLoginViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func loginEvent() {
        let navi = UINavigationController(rootViewController: TeacherHomeViewController())
        navi.navigationBar.tintColor = .black
        navi.navigationBar.barTintColor = .white
        navi.navigationBar.shadowImage = UIImage()
        self.present(navi, animated: true, completion: nil)
    }
    
    @IBAction func signUpEvnent() {
        let vc = TeacherSignUpViewController()
        self.showPopupView(vc: vc)
    }

}
