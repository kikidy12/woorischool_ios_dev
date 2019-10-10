//
//  ParentsSignUpStep2ViewController.swift
//  woorischool
//
//  Created by 권성민 on 03/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ParentsSignUpStep2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func completeSignUp() {
        let vc = ParentsHomeViewController()
        let navi = UINavigationController(rootViewController: vc)
        navi.navigationBar.tintColor = .black
        navi.navigationBar.barTintColor = .white
        navi.navigationBar.shadowImage = UIImage()
        self.present(navi, animated: true, completion: nil)
        
    }
}
