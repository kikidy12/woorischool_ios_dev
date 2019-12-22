//
//  BoardAddAndEditViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/21.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Alamofire

class BoardAddAndEditViewController: UIViewController {
    
    var editMode = false
    
    var board: BoardData!
    
    var lectureClass: LectureClassData!
    
    var imageList = [UIImage]() {
        didSet {
            if imageList.isEmpty {
                imagePlaceHolderView.isHidden = false
            }
            else {
                imagePlaceHolderView.isHidden = true
            }
            
            imageCollectionView.reloadData()
        }
    }
    
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imagePlaceHolderView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
        imageCollectionView.register(UINib(nibName: "PictureImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        navibarSetting()
        settingBoardView()
    }
    
    @IBAction func showCameraSelectViewEvent() {
        let vc = SelectCameraTypeViewController()
        vc.selectImagePickClouser = {
            self.imageList.append($0)
        }
        self.showPopupView(vc: vc)
    }
    
    func settingBoardView() {
        if board != nil {
            editMode = true
            imageList = board.imageList.compactMap {
                guard let url = $0.url, let data = try? Data(contentsOf: url)  else {
                    return nil
                }
                return UIImage(data: data)
            }
            
            textView.text = board.content.decodeEmoji
        }
    }

    func navibarSetting() {
//        title = "\(lectureClass.lecture?.name ?? "강좌") \(lectureClass.name ?? "클래스")"
        let uploadBtn = UIBarButtonItem(title: "업로드", style: .plain, target: self, action: #selector(uploadEvnet))
        
        uploadBtn.tintColor = .greenishTeal
        
        navigationItem.rightBarButtonItem = uploadBtn
    }
    
    @objc func uploadEvnet() {
        if editMode {
            editBoard()
        }
        else {
            addBoard()
        }
    }
    
    @objc func hideKeyBoard() {
        textView.resignFirstResponder()
    }

}

extension BoardAddAndEditViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PictureImageCollectionViewCell
        cell.initView(imageList[indexPath.item])
        cell.deleteClouser = {
            self.imageList.removeLast()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 86, height: 86)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension BoardAddAndEditViewController {
    func editBoard() {
        guard let id = board?.id, let idData = "\(id)".data(using: .utf8) else {
            return
        }
        guard let content = textView.text, !content.isEmpty, let contentData = content.data(using: .nonLossyASCII, allowLossyConversion: true) else {
            return
        }
        
        ServerUtil.shared.patchV2Board(vc: self, multipartFormData: { (formData) in
            formData.append(idData, withName: "board_id")
            formData.append(contentData, withName: "content")
            self.imageList.forEach {
                formData.append($0.resizeImage(width: 500)!, withName: "image", fileName: "boardImage.jpeg", mimeType: "image/jpeg")
            }
            
        }) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addBoard() {
        guard let id = lectureClass?.id, let idData = "\(id)".data(using: .utf8) else {
            return
        }
        guard let content = textView.text, !content.isEmpty, let contentData = content.data(using: .nonLossyASCII, allowLossyConversion: true) else {
            return
        }
        
        ServerUtil.shared.putV2Board(vc: self, multipartFormData: { (formData) in
            formData.append(idData, withName: "lecture_class_id")
            formData.append(contentData, withName: "content")
            self.imageList.forEach {
                formData.append($0.resizeImage(width: 500)!, withName: "image", fileName: "boardImage.jpeg", mimeType: "image/jpeg")
            }
            
        }) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
