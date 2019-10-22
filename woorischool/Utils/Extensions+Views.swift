//
//  Extensions+Views.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation
import Kingfisher


extension UIViewController {
    func closeVc(goToRoot: Bool = false, destination: UIViewController? = nil) {
        if let navi = self.navigationController {
            if goToRoot {
                navi.popToRootViewController(animated: true)
            }
            else {
                if let dest = destination {
                    navi.popToViewController(dest, animated: true)
                }
                else {
                    navi.popViewController(animated: true)
                }
            }
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func showPopupView(vc: UIViewController) {
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
    }
    
    func phoneCallRequest(_ phoneNum: String) {
        guard let url = URL(string: "tel://\(phoneNum)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var closeEventInputAccessary:UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let spaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeBtn = UIBarButtonItem(title: "close", style: .plain, target: self, action: #selector(closeTextField))
        toolbar.items = [spaceBar, closeBtn]
        return toolbar
    }
    
    @objc func closeTextField() {
        self.view.endEditing(true)
    }
    
    func phoneCall(_ phoneNum: String) {
        guard let url = URL(string: "tel://\(phoneNum)") else { return }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        
    }
    
    func openNaverNavi(lat: Double, lng: Double) {
        let urlString = "nmap://navigation?dlat=\(lat)&dlng=\(lng)"
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, completionHandler: nil)
            }
            else {
                UIApplication.shared.open(URL(string: "https://itunes.apple.com/kr/app/id311867728?mt=8")!, completionHandler: nil)
            }
        }
    }
    
    
    @IBAction func closeView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func showToast(message : String, font: UIFont) {
        
        let label = UILabel()
        label.text = message
        label.font = font
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.sizeToFit()
        let toastView = UIView()
        toastView.frame.size = CGSize(width: label.frame.width + 40, height: label.frame.height + 20)
        toastView.center.x = view.center.x
        toastView.frame.origin.y = UIScreen.main.bounds.height - label.frame.height - 20 - 50
        print(toastView.frame)
        toastView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastView.alpha = 1.0
        toastView.layer.cornerRadius = 10;
        toastView.clipsToBounds = true
        label.frame = toastView.bounds
        toastView.addSubview(label)
        self.view.addSubview(toastView)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseIn, animations: {
             toastView.alpha = 0.0
        }, completion: {(isCompleted) in
            toastView.removeFromSuperview()
        })
    }
}

