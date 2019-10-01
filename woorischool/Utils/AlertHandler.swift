//
//  AlertHandler.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//


import UIKit

class AlertHandler: NSObject {
    static let shared = AlertHandler()
    fileprivate var currentVC: UIViewController!
    
    func showAlert(vc: UIViewController, title: String? = nil, message:String, okTitle:String, cancelTitle: String? = nil, okHandler: ((UIAlertAction) -> Void)? = nil, cancelHandler: ((UIAlertAction) -> Void)? = nil) {
        currentVC = vc
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: okHandler))
        if let title = cancelTitle {
            alert.addAction(UIAlertAction(title: title, style: .cancel, handler: cancelHandler))
        }
        vc.present(alert, animated: true, completion: nil)
    }
}
