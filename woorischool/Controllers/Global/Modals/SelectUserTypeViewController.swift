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
    
    @IBAction func showParentsLoginViewEvent() {
        showLoginView(type: .parents)
    }
    
    @IBAction func showStudentLoginViewEvent() {
        showLoginView(type: .student)
    }
    
    @IBAction func showTeacherLoginViewEvent() {
        showLoginView(type: .teacher)
    }
    
    func showLoginView(type: UserType) {
        var vc: UIViewController!
        switch type {
        case .student:
            vc = ParentsLoginViewController()
            vc.title = " "
            break
        case .parents:
            vc = ParentsLoginViewController()
            vc.title = " "
            break
        case .teacher:
            vc = TeacherHomeViewController()
            vc.title = " "
            break
        }
        
        let navi = UINavigationController(rootViewController: vc)
        navi.navigationBar.tintColor = .black
        navi.navigationBar.barTintColor = .white
        navi.navigationBar.shadowImage = UIImage()
        self.present(navi, animated: true, completion: nil)
    }
}
