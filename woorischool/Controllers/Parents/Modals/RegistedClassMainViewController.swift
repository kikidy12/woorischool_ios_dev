//
//  RegistedClassMainViewController.swift
//  woorischool
//
//  Created by 권성민 on 04/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class RegistedClassMainViewController: UIViewController {
    
    var type: String = "CONFIRM"
    
    var quater: QuaterData! {
        didSet {
            if type == "CONFIRM" {
                setHeaderViews(headerFirstBtn)
            }
            else {
                setHeaderViews(headerSecondBtn)
            }
        }
    }
    
    var lectureClassList = [LectureClassData]() {
        didSet {
            if lectureClassList.isEmpty {
                
            }
            else {
                
            }
            
            classTabelView.reloadData()
        }
    }
    
    @IBOutlet weak var headerFirstView: UIView!
    @IBOutlet weak var headerFirstBtn: UIButton!
    @IBOutlet weak var headerSecondView: UIView!
    @IBOutlet weak var headerSecondBtn: UIButton!
    @IBOutlet weak var alertLabel: UILabel!
    
    @IBOutlet weak var classTabelView: UITableView!
    @IBOutlet weak var classTableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classTabelView.delegate = self
        classTabelView.dataSource = self
        
        classTabelView.register(UINib(nibName: "RegistedClassTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        
        let attributedString = NSMutableAttributedString(string: "12:00 시간 이내에 수강확정이 되지 않으면 \n다음 대기자에게 수강신청 권한이 넘어갑니다", attributes: [
            .font: UIFont(name: "NotoSansCJKkr-Regular", size: 14.0)!,
            .foregroundColor: UIColor.grapefruit,
            .kern: 0.0
            ])
        attributedString.addAttribute(.font, value: UIFont(name: "NotoSansCJKkr-Medium", size: 14.0)!, range: NSRange(location: 0, length: 5))

        alertLabel.attributedText = attributedString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "신청현황"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getQuater()
    }
    
    func setHeaderViews(_ sender: UIButton) {
        if sender.superview == headerFirstView {
            if let lineView = headerFirstView.subviews.last {
                sender.setTitleColor(.greyishBrown, for: .normal)
                lineView.backgroundColor = .greyishBrown
            }
            if let lineView = headerSecondView.subviews.last, let btn = headerSecondView.subviews.first as? UIButton {
                btn.setTitleColor(.brownGrey, for: .normal)
                lineView.backgroundColor = .clear
            }
            type = "CONFIRM"
        }
        if sender.superview == headerSecondView {
            if let lineView = headerSecondView.subviews.last {
                sender.setTitleColor(.greyishBrown, for: .normal)
                lineView.backgroundColor = .greyishBrown
            }
            if let lineView = headerFirstView.subviews.last, let btn = headerFirstView.subviews.first as? UIButton {
                btn.setTitleColor(.brownGrey, for: .normal)
                lineView.backgroundColor = .clear
            }
            
            type = "WAIT"
        }
        
        getLectureClass()
    }


    @IBAction func selectHeader(_ sender: UIButton) {
        setHeaderViews(sender)
    }

}

extension RegistedClassMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RegistedClassTableViewCell {
            cell.initView(lectureClassList[indexPath.item], type: type, quater: quater)
        }
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            classTableViewHeightConstraint.constant = cell.frame.height * CGFloat(lectureClassList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectureClassList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! RegistedClassTableViewCell
        
        cell.requestClouser = {
            let vc = ConfirmClassViewController()
            vc.preVC = self
            vc.lectureClass = self.lectureClassList[indexPath.item]
            vc.closeClouser = {
                self.getLectureClass()
            }
            self.showPopupView(vc: vc)
        }
        
        cell.cancelClouser = {
            AlertHandler().showAlert(vc: self, message: "취소하시겠습니까?", okTitle: "확인", cancelTitle: "닫기", okHandler: { (_) in
                guard let id = self.lectureClassList[indexPath.item].applyId else { return }
                self.cancelClass(id: id)
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ClassInfoPopupViewController()
        vc.lectureClass = lectureClassList[indexPath.item]
        showPopupView(vc: vc)
    }
    
}

extension RegistedClassMainViewController {
    func getLectureClass() {
        let parameters = [
            "status": type
        ] as [String:Any]
        ServerUtil.shared.getLectureApply(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["lecture_class"] as? NSArray else {
                return
            }
            
            self.lectureClassList = array.compactMap { LectureClassData($0 as! NSDictionary) }
        }
    }
    
    func cancelClass(id: Int) {
        let parameters = [
            "lecture_apply_id": id
        ] as [String:Any]
        ServerUtil.shared.deleteLectureApply(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.getLectureClass()
        }
    }
    
    func getQuater() {
        
        ServerUtil.shared.getSchoolQuarterInfo(self) { (success, dict, message) in
            guard success, let quater = dict?["school_quarter"] as? NSDictionary else {
                return
            }
            
            self.quater = QuaterData(quater)
        }
    }
}
