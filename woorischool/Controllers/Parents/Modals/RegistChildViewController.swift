//
//  RegistChildViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/10.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistChildViewController: UIViewController {
    
    var preVC: UIViewController!
    
    var schoolList = [SchoolData]() {
        didSet {
            pickerView.reloadAllComponents()
        }
    }
    
    var selectedSchool: SchoolData!
    
    var pickerView = UIPickerView(frame: .zero)
    
    var accessaryView: UIToolbar!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var schoolNumberTextField: UITextField!
    @IBOutlet weak var gradeTextField: UITextField!
    @IBOutlet weak var classNumberTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        accessaryView = UIToolbar()
        accessaryView.sizeToFit()
        let selectBtn = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectSchool))
        let spaceBar = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let closeBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closePickerView))
        
        accessaryView.items = [closeBtn, spaceBar, selectBtn]
        
        schoolNumberTextField.inputView = pickerView
        schoolNumberTextField.inputAccessoryView = accessaryView
        
        getSchoolList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        title = " "
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func selectSchool() {
        selectedSchool = schoolList[pickerView.selectedRow(inComponent: 0)]
        schoolNumberTextField.text = "\(selectedSchool.name ?? "미확인") (\(selectedSchool.number ?? "0000"))"
        schoolNumberTextField.resignFirstResponder()
    }
    
    @objc func closePickerView() {
        schoolNumberTextField.resignFirstResponder()
    }
    
    @IBAction func addChildEvent() {
        registChild()
    }
    
    @IBAction func showSchoolListEvent() {
        let vc = SearchSchoolViewController()
        vc.clouser = {
            self.schoolNumberTextField.text = $0
        }
        self.show(vc, sender: nil)
    }
}

extension RegistChildViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schoolList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schoolList[row].name
    }
}

extension RegistChildViewController {
    
    func getSchoolList() {
        let parameters = [
            "name": ""
        ] as [String:Any]
        ServerUtil.shared.getSchool(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["school"] as? NSArray else {
                return
            }
            
            self.schoolList = array.compactMap { SchoolData($0 as! NSDictionary) }
        }
    }
    func registChild() {
        
        guard let name = nameTextField.text, let password = passwordTextField.text, let grade = gradeTextField.text, let classNum = classNumberTextField.text, let number = numberTextField.text else {
            return
        }
        
        if name.isEmpty {
            AlertHandler().showAlert(vc: self, message: "이름을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if password.isEmpty {
            AlertHandler().showAlert(vc: self, message: "비밀번호를 입력해주세요.", okTitle: "확인")
            return
        }
        
        if selectedSchool == nil {
            AlertHandler().showAlert(vc: self, message: "학교를 선택해주세요.", okTitle: "확인")
            return
        }
        
        if grade.isEmpty {
            AlertHandler().showAlert(vc: self, message: "학년을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if classNum.isEmpty {
            AlertHandler().showAlert(vc: self, message: "반을 입력해주세요.", okTitle: "확인")
            return
        }
        
        if number.isEmpty {
            AlertHandler().showAlert(vc: self, message: "학생번호를 입력해주세요.", okTitle: "확인")
            return
        }
        
        let parameters = [
            "name": name,
            "password": password,
            "school_number": selectedSchool.number!,
            "grade": grade,
            "class_number": classNum,
            "number": number
        ] as [String: Any]
        
        print(parameters)
        ServerUtil.shared.postParentStudent(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler().showAlert(vc: self, message: message ?? "error", okTitle: "확인")
                return
            }
            UserDefs.setHasChildren(true)
            if self.navigationController == nil {
                let navi = UINavigationController(rootViewController: ParentsHomeViewController())
                navi.navigationBar.tintColor = .black
                navi.navigationBar.barTintColor = .white
                navi.navigationBar.shadowImage = UIImage()
                UIApplication.shared.keyWindow?.rootViewController = navi
            }
            else {
                self.navigationController?.popViewController(animated: true)
            }
//            if self.navigationController!.viewControllers.contains(where: {$0 is ParentsLoginViewController}) {
//                let vc = ParentsHomeViewController()
//                self.show(vc, sender: nil)
//            }
//            else {
//                self.navigationController?.popViewController(animated: true)
//            }
        }
    }
}
