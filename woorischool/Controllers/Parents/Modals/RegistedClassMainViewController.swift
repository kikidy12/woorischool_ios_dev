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
            let total = lectureClassList.reduce(0) { $0 + $1.price }
            setPayInfo(point: GlobalDatas.currentUser.childlen.point, total: total)
            classTabelView.reloadData()
        }
    }
    
    @IBOutlet weak var headerFirstView: UIView!
    @IBOutlet weak var headerFirstBtn: UIButton!
    @IBOutlet weak var headerSecondView: UIView!
    @IBOutlet weak var headerSecondBtn: UIButton!
    
    @IBOutlet weak var classTabelView: UITableView!
    
    @IBOutlet weak var expendBtn: UIView!
    @IBOutlet weak var expendView: UIView!
    @IBOutlet weak var payInfoBottomView: UIView!
    @IBOutlet weak var expendViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var usePointLabel: UILabel!
    @IBOutlet weak var pointResultLabel: UILabel!
    @IBOutlet weak var payPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        classTabelView.delegate = self
        classTabelView.dataSource = self
        
        classTabelView.register(UINib(nibName: "RegistedClassTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        classTabelView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 1, height: 0.001))
        classTabelView.estimatedRowHeight = 300
        classTabelView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "신청현황"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getQuater()
    }
    
    func setPayInfo(point: Int, total: Int) {
        totalPriceLabel.text = "\(total.decimalString ?? "0") 원"
        
        if total == 0 {
            usePointLabel.text = "0 원"
            pointResultLabel.text = "(보유 : \(point.decimalString ?? "0") 원 / 차감 후 : \(point.decimalString ?? "0") 원)"
            return
        }
        
        let lastPoint = point - total
    
        if lastPoint > 0 {
            usePointLabel.text = "\(total.decimalString ?? "0") 원"
            pointResultLabel.text = "(보유 : \(point.decimalString ?? "0") 원 / 차감 후 : \(lastPoint.decimalString ?? "0") 원)"
            payPriceLabel.text = "0 원"
        }
        else {
            usePointLabel.text = "\(point.decimalString ?? "0") 원"
            pointResultLabel.text = "(보유 : \(point.decimalString ?? "0") 원 / 차감 후 : 0 원)"
            payPriceLabel.text = "\((total - point).decimalString ?? "0") 원"
        }
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
            expendBtn.isHidden = false
            expendView.isHidden = false
            payInfoBottomView.isHidden = false
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
            
            expendBtn.isHidden = true
            expendView.isHidden = true
            payInfoBottomView.isHidden = true
            type = "WAIT"
        }
        
        getLectureClass()
    }

    @IBAction func showAndHideExpendViewEvent(_ sender: UIButton) {
        if sender.tag == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.expendViewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }) { (_) in
                self.expendView.alpha = 0
            }
            if #available(iOS 13.0, *) {
                sender.setImage(UIImage(systemName: "chevron.compact.up"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
            sender.tag = 0
        }
        else {
            self.expendView.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.expendViewTopConstraint.constant = -self.expendView.frame.height
                self.view.layoutIfNeeded()
            }) { (_) in
                
            }
            if #available(iOS 13.0, *) {
                sender.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
            sender.tag = 1
        }
    }

    @IBAction func selectHeader(_ sender: UIButton) {
        setHeaderViews(sender)
    }

}

extension RegistedClassMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if type == "CONFIRM" {
            return nil
        }
        else {
            let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
            headerView.backgroundColor = .paleGreyThree
            let titleLabel = UILabel()
            titleLabel.frame.size = .init(width: headerView.frame.width, height: 50)
            titleLabel.center = headerView.center
            titleLabel.textAlignment = .center
            titleLabel.text = "12:00 시간 이내에 수강호가정\n그런거 있다"
            titleLabel.textColor = .grapefruit
            titleLabel.backgroundColor = .grapefruit10
            
            headerView.addSubview(titleLabel)
            return headerView
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if type == "CONFIRM" {
            return 20
        }
        else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if type == "CONFIRM" {
            return 20
        }
        else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lectureClassList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! RegistedClassTableViewCell
        cell.initView(lectureClassList[indexPath.item], type: type, quater: quater)
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
