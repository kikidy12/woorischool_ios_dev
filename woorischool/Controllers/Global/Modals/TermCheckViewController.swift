//
//  TermCheckViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/27.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TermCheckViewController: UIViewController {
    
    @IBOutlet weak var allTermBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    
    @IBOutlet weak var firstTermView: UIView!
    @IBOutlet weak var secondTermView: UIView!
    @IBOutlet weak var thirdTermView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func allCheckEvent() {
        if allTermBtn.tag == 0 {
            firstTermView.tag = 0
            secondTermView.tag = 0
            thirdTermView.tag = 0
        }
        else {
            firstTermView.tag = 1
            secondTermView.tag = 1
            thirdTermView.tag = 1
        }
        
        setTermView(termView: firstTermView)
        setTermView(termView: secondTermView)
        setTermView(termView: thirdTermView)
    }

    @IBAction func termCheckEvent(_ sender: UIButton) {
        guard let termView = sender.superview else {
            return
        }
        setTermView(termView: termView)
    }
    
    @IBAction func showTermEvent(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            break
        case 1:
            break
        case 2:
        break
        default:
            break
        }
    }
    
    @IBAction func agreeEvent(_ sender: UIButton) {
        if sender.backgroundColor == .greenishTeal {
            agreeTerm()
        }
        else {
            return
        }
    }
    
    func setTermView(termView: UIView) {
        guard let nessasaryLabel = termView.subviews.first(where: {$0 is UILabel}) as? UILabel, let checkImageView = termView.subviews.first(where: {$0 is UIImageView}) as? UIImageView else {
            return
        }
        
        if termView.tag == 0 {
            termView.tag = 1
            checkImageView.tintColor = .greenishTeal
            nessasaryLabel.textColor = .greenishTeal
        }
        else {
            termView.tag = 0
            checkImageView.tintColor = .brownGrey
            nessasaryLabel.textColor = .brownGrey
        }
        
        if firstTermView.tag == 1, secondTermView.tag == 1, thirdTermView.tag == 1 {
            allTermBtn.tag = 1
            allTermBtn.tintColor = .greenishTeal
        }
        else {
            allTermBtn.tag = 0
            allTermBtn.tintColor = .brownGrey
        }
        setNextBtn()
    }
    
    func setNextBtn() {
        if firstTermView.tag == 1, secondTermView.tag == 1 {
            agreeBtn.backgroundColor = .greenishTeal
        }
        else {
            agreeBtn.backgroundColor = .brownGrey
        }
    }
}

extension TermCheckViewController {
    func agreeTerm() {
        
    }
}
