//
//  CourseRegistrationViewController.swift
//  woorischool
//
//  Created by 권성민 on 03/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class CourseRegistrationViewController: UIViewController {
    
    var courseList = [String]()
    
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
    @IBOutlet weak var filterTextField: UITextField!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    @IBOutlet weak var courseCollectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chooseableCorseTableView: UITableView!
    @IBOutlet weak var chooseableCorseTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        accessaryView = UIToolbar()
        navibarSetting()
        courseList = ["B","B","B","B","B","B","B","B"]
        filterTextField.inputAccessoryView = accessaryView
        courseCollectionView.delegate = self
        courseCollectionView.dataSource = self
        chooseableCorseTableView.delegate = self
        chooseableCorseTableView.dataSource = self
        chooseableCorseTableView.register(UINib(nibName: "RegistClassTableViewCell", bundle: nil), forCellReuseIdentifier: "classCell")
        courseCollectionView.register(UINib(nibName: "CourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "courseCell")
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
}

extension CourseRegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RegistClassTableViewCell {
            cell.initView(indexPath.item)
        }
        if indexPath.item == (tableView.indexPathsForVisibleRows!.last!).item {
            chooseableCorseTableViewHeightConstraint.constant = tableView.contentSize.height
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "classCell", for: indexPath) as! RegistClassTableViewCell
        
        return cell
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
        if courseList[indexPath.item] == "A" {
            courseList[indexPath.item] = "B"
        }
        else {
            courseList[indexPath.item] = "A"
        }
        let cell = collectionView.cellForItem(at: indexPath) as! CourseCollectionViewCell
        cell.initView(courseList[indexPath.item])
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 4.0 - 10, height: 30)
    }
    
}
