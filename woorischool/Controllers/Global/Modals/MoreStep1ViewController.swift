//
//  MoreStep1ViewController.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/09.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit

class MoreStep1ViewController: UIViewController {
    
    var userType: UserType = UserType(rawValue: UserDefs.lastUserType) ?? .parents
    
    @IBOutlet weak var userTypeLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var profileImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        userNameLabel.text = GlobalDatas.currentUser.name
        if userType == .parents {
            stackView.arrangedSubviews.first?.isHidden = false
            searchImageView.isHidden = false
            userTypeLabel.text = ""
            userInfoLabel.text = GlobalDatas.currentUser.phoneNum
        }
        else if userType == .teacher {
            stackView.arrangedSubviews.first?.isHidden = true
            searchImageView.isHidden = true
            userTypeLabel.text = "선생님"
            userInfoLabel.text = GlobalDatas.currentUser.email
        }
        else {
            stackView.arrangedSubviews.first?.isHidden = false
            searchImageView.isHidden = false
            userTypeLabel.text = ""
            userInfoLabel.text = GlobalDatas.currentUser.phoneNum
        }
        if let urlStr = GlobalDatas.currentUser.profileImage {
            profileImageView.kf.setImage(with: URL(string: urlStr), placeholder: UIImage(named: "profilePlaceHolder"))
        }
        else {
            profileImageView.image = UIImage(named: "profilePlaceHolder")
        }
    }

    
    @IBAction func showMyBoardListEvent() {
        let vc = ClassBoardListViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showChildrenListViewEvent() {
        let vc = ManageChildrenViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showMyQuaterClassListEvent() {
        let vc = QuarterClassListViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showNotiListViewEvent() {
        let vc = NotiListViewController()
        show(vc, sender: nil)
    }
    
    @IBAction func showAttractViewEvent() {
        createAndShowQNA()
    }
    
    @IBAction func showEditProfileViewEvent() {
        let vc = EditProfileViewController()
        vc.isEditMode = true
        self.show(vc, sender: nil)
    }
    
    @IBAction func showSearchMapEvent() {
//        AlertHandler().showAlert(vc: self, message: "준비중인 기능입니다.", okTitle: "확인")
        let vc = MapViewController()
        self.show(vc, sender: nil)
    }
    
    @IBAction func showMoreViewEvent() {
        let vc = MyPageViewController()
        self.show(vc, sender: nil)
    }
    
}

extension MoreStep1ViewController {
    func createAndShowQNA() {
        guard userType == .parents else {
            AlertHandler().showAlert(vc: self, message: "학부모 전용 기능입니다.", okTitle: "확인")
            return
        }
        
        ServerUtil.shared.getNoteQna(self) { (success, dict, message) in
            guard success, let room = dict?["note"] as? NSDictionary  else {
                return
            }
            
            let vc = ChattingViewController()
            vc.room = ChatRoomData(room)
            self.show(vc, sender: nil)
        }
    }
}
