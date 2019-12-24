//
//  ParentsEditProfileViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/22.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    var isEditProfileImage = false
    
    var isEditMode = false
    
    @IBOutlet weak var profileImaegView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var textCountLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navibarSetting()
        
        if isEditMode {
            profileImaegView.image = GlobalDatas.currentUser.profileImage ?? #imageLiteral(resourceName: "profilePlaceHolder")
            nameTextField.text = GlobalDatas.currentUser.name
            
            profileImaegView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(editProfileImageEvent(_:))))
        }
    }

    
    func navibarSetting() {
        let rightBarBtn = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(nextEvent))
        rightBarBtn.tintColor = .greenishTeal
        
        rightBarBtn.title = isEditMode ? "수정" : "다음"
        navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    @objc func nextEvent() {
        editProfile()
    }
    
    @objc func editProfileImageEvent(_ sender: UITapGestureRecognizer) {
        let vc = SelectCameraTypeViewController()
        vc.selectImagePickClouser = { image in
            self.profileImaegView.image = image
            self.isEditProfileImage = true
        }
        self.showPopupView(vc: vc)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func editTextChange(_ sender: UITextField) {
        guard let text = sender.text else {
            return
        }
        
        if text.count > 5 {
            sender.text = String(text.dropLast())
            textCountLabel.text = "5/5"
        }
        else {
            textCountLabel.text = "\(text.count)/5"
        }
        
    }

}

extension EditProfileViewController {
    func editProfile() {
        guard let nickName = nameTextField.text, nibName != nil else {
            AlertHandler().showAlert(vc: self, message: "닉네임을 입력해주세요.", okTitle: "확인")
            return
        }
        
        let image = self.profileImaegView.image
        
        
        ServerUtil.shared.patchAuth(vc: self, multipartFormData: { (multi) in
            multi.append(nickName.data(using: .utf8)!, withName: "name")
            if self.isEditProfileImage, let imageData = image!.resizeImage(width: 300) {
                multi.append(imageData, withName: "image", fileName: "profileImage.jpeg", mimeType: "image/jpeg")
            }
        }) { (success, dict, message) in
            guard success else {
                return
            }
            if self.isEditMode {
                self.navigationController?.popViewController(animated: true)
            }
            else {
                if GlobalDatas.currentUser.childlen == nil {
                    UserDefs.setHasChildren(false)
                    UIApplication.shared.keyWindow?.rootViewController = RegistChildViewController()
                }
                else {
                    UserDefs.setHasChildren(true)
                    let navi = UINavigationController(rootViewController: ParentsMainViewController())
                    navi.navigationBar.tintColor = .black
                    navi.navigationBar.barTintColor = .white
                    navi.navigationBar.shadowImage = UIImage()
                    UIApplication.shared.keyWindow?.rootViewController = navi
                }
            }
        }
    }
}
