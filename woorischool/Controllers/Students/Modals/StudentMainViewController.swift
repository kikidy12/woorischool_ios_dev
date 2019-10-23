//
//  StudentMainViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/22.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class StudentMainViewController: UIViewController {
    
    @IBOutlet weak var tabStackView: UIStackView!
    @IBOutlet weak var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTabViews(tabStackView.arrangedSubviews.first!)
    }

    
    @IBAction func selectTapEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            settingTabViews(sender.view!)
        }
    }
    
    func settingTabViews(_ selectView: UIView) {
        tabStackView.arrangedSubviews.enumerated().forEach {
            guard let imageView = $0.element.subviews.first(where: {$0 is UIImageView}),
            let label = $0.element.subviews.first(where: {$0 is UILabel}) as? UILabel,
                let lineView = $0.element.subviews.first
            else {
                return
            }
            if $0.element == selectView {
                imageView.tintColor = .greenishTeal
                label.textColor = .greenishTeal
                lineView.isHidden = false
                
                switch $0.offset {
                case 0:
                    setMainViews(vc: StudentHomeViewController())
                    break
                case 1:
                    setMainViews(vc: StudentBoardListViewController())
                    break
                case 2:
                    setMainViews(vc: StudentChattingRoomListViewController())
                    break
                case 3:
                    setMainViews(vc: StudentMyInfoViewController())
                    break
                default:
                    break
                }
            }
            else {
                imageView.tintColor = .brownGrey
                label.textColor = .brownGrey
                lineView.isHidden = true
            }
            
        }
    }
    
    func setMainViews(vc: UIViewController) {
        self.children.forEach {
            $0.removeFromParent()
            $0.view.removeFromSuperview()
        }
        self.addChild(vc)
        vc.view.frame = self.mainView.bounds
        self.mainView.addSubview(vc.view)
    }

}
