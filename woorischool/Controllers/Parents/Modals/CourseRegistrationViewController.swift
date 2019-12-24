//
//  CourseRegistrationViewController.swift
//  woorischool
//
//  Created by 권성민 on 03/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class CourseRegistrationViewController: UIViewController {

    var courseList = [LectureAreaData]() {
        didSet {
            if courseList.isEmpty {
                
            }
            else {
                
            }
            
            courseCollectionView.reloadData()
            
            getLectureClass()
        }
    }
    
    var lectureList = [LectureClassData]() {
        didSet {
            filterLectureList = lectureList
        }
    }
    
    var filterLectureList = [LectureClassData]() {
        didSet {
            if lectureList.isEmpty {
                
            }
            else {
                
            }
            filterCoutLabel.text = "총 \(filterLectureList.count) 강좌"
            chooseableCorseTableView.reloadData()
        }
    }
    
    var accessaryView: UIToolbar! {
        didSet {
            accessaryView.sizeToFit()
//            let button1 = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectDate))
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let button2 = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(closeTextField))
            accessaryView.items = [space, button2]
        }
    }
    
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterCoutLabel: UILabel!
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var filterStackView: UIStackView!
    @IBOutlet weak var filterLabelView: UIView!
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var courseCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chooseableCorseTableView: UITableView!
    @IBOutlet weak var chooseableCorseTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var expendView: UIView!
    @IBOutlet weak var expendViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var usePointLabel: UILabel!
    @IBOutlet weak var pointResultLabel: UILabel!
    @IBOutlet weak var payPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accessaryView = UIToolbar()
        navibarSetting()
        filterTextField.inputAccessoryView = accessaryView
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        chooseableCorseTableView.delegate = self
        chooseableCorseTableView.dataSource = self
        chooseableCorseTableView.register(UINib(nibName: "RegistClassTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        courseCollectionView.register(UINib(nibName: "CourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "courseCell")
        getCourse()
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "수강신청"
    }
    
    func navibarSetting() {
        let rightBtn = UIBarButtonItem(image: UIImage(named: "filterImage"), style: .plain, target: self, action: #selector(showFilterView))
        
        navigationItem.rightBarButtonItem = rightBtn
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
        }
        else {
            usePointLabel.text = "\(point.decimalString ?? "0") 원"
            pointResultLabel.text = "(보유 : \(point) 원 / 차감 후 : \(point) 원)"
        }
        
        payPriceLabel.text = "\((total - point).decimalString ?? "0") 원"
    }
    
    @IBAction func showAndHideExpendViewEvent(_ sender: UIButton) {
        if sender.tag == 1 {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.expendViewTopConstraint.constant = 0
                self.view.layoutIfNeeded()
            }) { (_) in
                self.expendView.alpha = 0
            }
            sender.setImage(UIImage(named: "chevron.compact.up"), for: .normal)
            sender.tag = 0
        }
        else {
            self.expendView.alpha = 1
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.expendViewTopConstraint.constant = -self.expendView.frame.height
                self.view.layoutIfNeeded()
            }) { (_) in
                
            }
            sender.setImage(UIImage(named: "chevron.compact.down"), for: .normal)
            sender.tag = 1
        }
    }

    @IBAction func selectDay(_ sender: UIButton) {
        if sender.tag == 0 {
            sender.layer.borderWidth = 0
            sender.backgroundColor = .greenishTeal
            sender.setTitleColor(.white, for: .normal)
            sender.tag = 1
        }
        else {
            sender.layer.borderWidth = 1
            sender.backgroundColor = .clear
            sender.setTitleColor(.greyishBrown, for: .normal)
            sender.tag = 0
        }
    }
    
    @objc func showFilterView() {
        filterView.isHidden = false
    }
    
    @IBAction func hideFilterView() {
        filterView.isHidden = true
    }
    
    @IBAction func filterByNmaesAndWeekDaysEvent() {
        filterView.isHidden = true
        getLectureClass()
    }
    
    @IBAction func filterByClassName(_ sender: UITextField) {
        guard let text = sender.text else { return }
        
        if text.isEmpty {
            filterLectureList = lectureList
        }
        else {
            filterLectureList = lectureList.filter {
                return $0.lecture.name.contains(text)
            }
        }
    }
}

extension CourseRegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? RegistClassTableViewCell {
            cell.initView(filterLectureList[indexPath.item])
        }
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            chooseableCorseTableViewHeightConstraint.constant = cell.frame.height * CGFloat(filterLectureList.count)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterLectureList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! RegistClassTableViewCell
        cell.requestClouser = {
            
            let vc = RegistClassPopupViewController()
            vc.lectureClass = self.filterLectureList[indexPath.item]
            vc.preVC = self
            self.showPopupView(vc: vc)
//            let vc = ClassRegistPopupViewController()
//            vc.lectureClass = self.filterLectureList[indexPath.item]
//            vc.preVC = self
//            self.showPopupView(vc: vc)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ClassInfoPopupViewController()
        vc.lectureClass = filterLectureList[indexPath.item]
        showPopupView(vc: vc)
    }
    
}

extension CourseRegistrationViewController: UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        courseCollectionViewHeightConstraint.constant = CGFloat(courseList.count / 4) * 45.0 + 30.0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as! CourseCollectionViewCell
        cell.initView(courseList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        courseList[indexPath.item].isSelected = !courseList[indexPath.item].isSelected
        let cell = collectionView.cellForItem(at: indexPath) as! CourseCollectionViewCell
        cell.initView(courseList[indexPath.item])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4.0 - 10, height: 30)
    }
    
}


extension CourseRegistrationViewController {
    func getCourse() {
        ServerUtil.shared.getLectureAreas(self) { (success, dict, message) in
            guard success, let array = dict?["lecture_area"] as? NSArray else {
                return
            }
            
            self.courseList = array.compactMap { LectureAreaData($0 as! NSDictionary)}
        }
    }
    
    func isUseAblePoint(classData: LectureClassData) {
        let parameters = [
            "lecture_class_id": classData.id!
        ] as [String:Any]
        
        ServerUtil.shared.postPointLectureApply(self, parameters: parameters) { (success, dict, message) in
            guard success, let possible = dict?["is_possible"] as? Bool, let price = dict?["lecture_price"] as? Int, let point = dict?["my_point"] as? Int else {
                return
            }
            GlobalDatas.currentUser.childlen.point = point
            
            
            
//            if possible {
//                let vc = ClassRegistPopupViewController()
//                vc.lectureClass = classData
//                vc.preVC = self
//                vc.price = price
//                self.showPopupView(vc: vc)
//            }
//            else {
//                let vc = RegistClassPopupViewController()
//                vc.lectureClass = classData
//                vc.preVC = self
//                self.showPopupView(vc: vc)
//            }
        }
    }
    
    func getLectureClass() {
        var areaIds = "["
        courseList.forEach {
            if $0.isSelected {
                areaIds += "\($0.id!)"
                if $0 != courseList.last {
                    areaIds += ","
                }
            }
        }
        areaIds += "]"
        
        var weekDays = "["
        let array = dayStackView.arrangedSubviews.filter {$0.tag == 1}
        dayStackView.arrangedSubviews.enumerated().forEach {
            if $0.element.tag == 1 {
                weekDays += "\($0.offset)"
                if $0.element != array.last {
                    weekDays += ","
                }
            }
        }
        weekDays += "]"
        
        if !courseList.contains(where: {$0.isSelected}), !dayStackView.arrangedSubviews.contains(where: {$0.tag == 1}) {
            filterLabelView.isHidden = true
        }
        else {
            filterLabelView.isHidden = false
            guard let label1 = filterStackView.arrangedSubviews.first as? UILabel else {
                return
            }
            
            guard let label2 = filterStackView.arrangedSubviews.last as? UILabel else {
                return
            }
            if courseList.contains(where: {$0.isSelected}) {
                label1.isHidden = false
                var searchStr = ""
                courseList.forEach {
                    if $0.isSelected {
                        searchStr += "\($0.name!)"
                        if $0 != courseList.last {
                            searchStr += "/"
                        }
                    }
                }
                
                label1.text = searchStr
            }
            else {
                label1.isHidden = true
            }
            
            
            if dayStackView.arrangedSubviews.contains(where: {$0.tag == 1}) {
                label2.isHidden = false
                var searchStr = ""
                let array = dayStackView.arrangedSubviews.filter {$0.tag == 1}
                array.forEach {
                    guard let btn = $0 as? UIButton else {
                        return
                    }
                    searchStr += "\(btn.title(for: .normal) ?? "")요일"
                    if $0 != array.last {
                        searchStr += "/"
                    }
                }
                
                label2.text = searchStr
            }
            else {
                label2.isHidden = true
            }
            
        }
        
        
        let parameters = [
            "lecture_area_ids": areaIds,
            "week_days": weekDays
        ] as [String:Any]
        print(parameters)
        ServerUtil.shared.getLecture(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["lecture_list"] as? NSArray, let totalPrice = dict?["apply_amount"] as? Int, let point = dict?["my_point"] as? Int else {
                return
            }
            
            self.lectureList = array.compactMap { LectureClassData($0 as! NSDictionary)}
            self.setPayInfo(point: point, total: totalPrice)
        }
    }
}
