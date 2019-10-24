//
//  SelectUserTypeViewController.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class SelectUserTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showParentsLoginViewEvent() {
        showLoginView(type: .parents)
    }
    
    @IBAction func showStudentLoginViewEvent() {
//        showToast(message: "준비중인 기능입니다.", font: .systemFont(ofSize: 15))
        showLoginView(type: .student)
    }
    
    @IBAction func showTeacherLoginViewEvent() {
        showToast(message: "준비중인 기능입니다.", font: .systemFont(ofSize: 15))
//        showLoginView(type: .teacher)
    }
    
    func showLoginView(type: UserType) {
        var vc: UIViewController!
        switch type {
        case .student:
            vc = StudentMainViewController()
            vc.title = " "
            break
        case .parents:
            vc = ParentsLoginViewController()
            vc.title = " "
            break
        case .teacher:
            vc = TeacherLoginViewController()
            vc.title = " "
            break
        }
        vc.title = " "
        show(vc, sender: nil)
    }
}
