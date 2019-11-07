//
//  RegistDailyNoteViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/06.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistDailyNoteViewController: UIViewController {
    
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
    
    var keyboardHeight:CGFloat = 0
    var isShowKeyboard:Bool = false
    
    var selectTextInputType:UIView!
    
    @IBOutlet weak var materialTextField: UITextField!
    @IBOutlet weak var homeWorkTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var imagePlaceHolderView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
        textView.delegate = self
        homeWorkTextField.delegate = self
        materialTextField.delegate = self
        
        imageCollectionView.register(UINib(nibName: "PictureImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func showCameraSelectViewEvent() {
        let vc = SelectCameraTypeViewController()
        vc.selectImagePickClouser = {
            self.imageList.append($0)
        }
        self.showPopupView(vc: vc)
    }

    @objc func keyboardWillShow(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            isShowKeyboard = true
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardHeight
            scrollView.contentInset = contentInset
        }
    }

    @objc func keyboardWillHide(note: NSNotification) {
        isShowKeyboard = false
        let contentInset:UIEdgeInsets = .zero
        scrollView.contentInset = contentInset
    }
    
    @objc func hideKeyBoard() {
        textView.resignFirstResponder()
        materialTextField.resignFirstResponder()
        homeWorkTextField.resignFirstResponder()
    }
}

extension RegistDailyNoteViewController: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        selectTextInputType = textView
        if isShowKeyboard {
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardHeight
            scrollView.contentInset = contentInset
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectTextInputType = textField
        if isShowKeyboard {
            var contentInset:UIEdgeInsets = self.scrollView.contentInset
            contentInset.bottom = keyboardHeight
            scrollView.contentInset = contentInset
        }
    }
}

extension RegistDailyNoteViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
