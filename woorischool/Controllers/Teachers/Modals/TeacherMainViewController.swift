//
//  TeacherMainViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/25.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TeacherMainViewController: UIViewController {
    
    var alarmList = [String]() {
        didSet {
            
        }
    }
    
    var alarmBtn = UIBarButtonItem(image: UIImage(), style: .plain, target: self, action: #selector(showAlarmEvent))

    @IBOutlet weak var tabStackView: UIStackView!
    @IBOutlet weak var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        getTeacherInfo {
            self.settingTabViews(self.tabStackView.arrangedSubviews.first!)
        }
        
    }
    
    @objc func showAlarmEvent() {
        
    }
    
    @objc func showSettingEvent() {
        
    }

    
    @IBAction func selectTapEvent(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            getTeacherInfo {
                self.settingTabViews(sender.view!)
            }
        }
    }
    
    func setLeftTitleSetting(_ str: String) {
        let customTitleView = MainTitleView(frame: CGRect(x: 0, y: 0, width: 150, height: 42))
//        customTitleView.translatesAutoresizingMaskIntoConstraints = false
//        customTitleView.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        customTitleView.heightAnchor.constraint(equalToConstant: 42).isActive = true
        let leftBtn = UIBarButtonItem(customView: customTitleView)
        self.navigationItem.leftBarButtonItem = leftBtn
        customTitleView.titleLabel.text = str
    }
    
    func navibarSetting() {
        alarmList = []
        
        navigationItem.rightBarButtonItems = [alarmBtn]
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
                    setMainViews(vc: TeacherHomeViewController())
                    setLeftTitleSetting("OSchool")
                    break
                case 1:
                    setMainViews(vc: BoardListViewController())
                    setLeftTitleSetting("게시판")
                    break
                case 2:
                    setMainViews(vc: ChattingRoomListViewController())
                    setLeftTitleSetting("소통방")
                    break
                case 3:
                    setMainViews(vc: MyPageViewController())
                    setLeftTitleSetting("내 정보")
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

    func getTeacherInfo(complete: @escaping ()->()) {
        let paramterts = [
            "device_token": GlobalDatas.deviceToken,
            "os": "iOS"
        ] as [String:Any]
        
        ServerUtil.shared.getV2Info(self, parameters: paramterts) { (success, dict, message) in
            guard success, let user = dict?["user"] as? NSDictionary else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            
            GlobalDatas.currentUser = UserData(user)
            complete()
        }
    }
}
