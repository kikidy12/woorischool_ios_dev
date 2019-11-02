//
//  ParentsEnrolmentClassViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsEnrolmentClassViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func showRegistViewEvent() {
        let vc = CourseRegistrationViewController()
        self.show(vc, sender: nil)
    }

    @IBAction func showRegistedClassViewEvent() {
        let vc = RegistedClassMainViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showCompleteRegistViewEvent() {
        let vc = RegistClassCompleteListViewController()
        self.show(vc, sender: nil)
    }
}
