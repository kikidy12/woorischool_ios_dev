//
//  RegistDailyNoteViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/06.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistDailyNoteViewController: UIViewController {
    
    var editMode = false
    
    var scheduleList = [LectureScheduleData]()
    
    var lectureClass: LectureClassData!
    
    var editSchedule: LectureScheduleData!
    
    var dailyNote: DailyNoteData! {
        didSet {
            if dailyNote == nil {
                settingDailyNote(false)
            }
            else {
                settingDailyNote(true)
            }
        }
    }
    
    var selectedSchedule: LectureScheduleData! {
        didSet {
            dateLabel.text = selectedSchedule.date.dateToString(formatter: "MM월 dd일자 알림장")
            getDailyNote()
        }
    }
    
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
    
    @IBOutlet weak var dateLabel: UILabel!
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
        
        
        let tempList = scheduleList.filter({
            $0.date.dateToString(formatter: "yyyy-MM-dd") >= Date().dateToString(formatter: "yyyy-MM-dd")
        })
        
        tempList.forEach {
            print($0.date.dateToString(formatter: "yyyy-MM-dd"))
        }
        if editSchedule != nil {
            selectedSchedule = editSchedule
        }
        else if tempList.isEmpty {
            selectedSchedule = scheduleList.last
        }
        else {
            selectedSchedule = tempList.last
        }
        
        
        navibarSetting()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func navibarSetting() {
        title = "\(lectureClass.lecture?.name ?? "강좌") \(lectureClass.name ?? "클래스")"
        let uploadBtn = UIBarButtonItem(title: "업로드", style: .plain, target: self, action: #selector(uploadEvnet))
        
        uploadBtn.tintColor = .greenishTeal
        
        navigationItem.rightBarButtonItem = uploadBtn
    }
    
    @objc func uploadEvnet() {
        if editMode {
            editDailyNote()
        }
        else {
            addDailyNote()
        }
    }
    
    
    func settingDailyNote(_ mode: Bool) {
        editMode = mode
        
        if editMode {
            textView.text = dailyNote.content
            materialTextField.text = dailyNote.materials
            homeWorkTextField.text = dailyNote.homework
            
            imageList = dailyNote.imageList.compactMap {
                guard let url = $0.url, let data = try? Data(contentsOf: url)  else {
                    return nil
                }
                return UIImage(data: data)
            }
        }
        else {
            textView.text = ""
            materialTextField.text = ""
            homeWorkTextField.text = ""
            
            imageList = [UIImage]()
        }
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
    
    @IBAction func selectNextDateEvent() {
        if let index = scheduleList.firstIndex(of: selectedSchedule), index < scheduleList.count - 1 {
            selectedSchedule = scheduleList[index + 1]
        }
        else {
            
        }
        
    }
    
    @IBAction func selectPreviosDateEvent() {
        if let index = scheduleList.firstIndex(of: selectedSchedule), index > 0 {
            selectedSchedule = scheduleList[index - 1]
        }
        else {
            
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

extension RegistDailyNoteViewController {
    func getDailyNote() {
        let parameters = [
            "lecture_schedule_id": selectedSchedule.id!
        ] as [String: Any]
        print(parameters)
        ServerUtil.shared.postV2Announcement(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler.shared.showAlert(vc: self, message: message ?? "Server Error", okTitle: "확인")
                return
            }
            guard let dailynote = dict?["announcement"] as? NSDictionary else {
                return
            }
            
            self.dailyNote = DailyNoteData(dailynote)
        }
    }
    
    func editDailyNote() {
        guard let id = selectedSchedule.id, let idData = "\(id)".data(using: .utf8) else {
            return
        }
        guard let content = textView.text, content.isEmpty, let contentData = content.data(using: .utf8) else {
            return
        }
        guard let material = materialTextField.text else {
            return
        }
        guard let homework = homeWorkTextField.text else {
            return
        }
        
        ServerUtil.shared.patchV2Announcement(vc: self, multipartFormData: { (formData) in
            formData.append(idData, withName: "lecture_schedule_id")
            formData.append(contentData, withName: "content")
            if !material.isEmpty {
                formData.append(material.data(using: .utf8)!, withName: "materials")
            }
            if !homework.isEmpty {
                formData.append(homework.data(using: .utf8)!, withName: "homework")
            }
            
            self.imageList.forEach {
                formData.append($0.jpegData(compressionQuality: 1.0)!, withName: "image", fileName: "announceImage", mimeType: "image/jpeg")
            }
            
        }) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func addDailyNote() {
        guard let id = selectedSchedule.id, let idData = "\(id)".data(using: .utf8) else {
            return
        }
        guard let content = textView.text, content.isEmpty, let contentData = content.data(using: .utf8) else {
            return
        }
        guard let material = materialTextField.text else {
            return
        }
        guard let homework = homeWorkTextField.text else {
            return
        }
        
        ServerUtil.shared.putV2Announcement(vc: self, multipartFormData: { (formData) in
            formData.append(idData, withName: "lecture_schedule_id")
            formData.append(contentData, withName: "content")
            if !material.isEmpty {
                formData.append(material.data(using: .utf8)!, withName: "materials")
            }
            if !homework.isEmpty {
                formData.append(homework.data(using: .utf8)!, withName: "homework")
            }
            
            self.imageList.forEach {
                formData.append($0.jpegData(compressionQuality: 1.0)!, withName: "image", fileName: "announceImage", mimeType: "image/jpeg")
            }
            
        }) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
