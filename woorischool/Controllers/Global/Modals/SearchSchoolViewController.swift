//
//  SearchSchoolViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

//extension UIView {
//    func initWithNibName<T>(nibName: String) -> T {
//        let viewsInNib = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
//        var returnView: T!
//        for view in viewsInNib! {
//            if let view = view as? T {
//                returnView = view
//                break
//            }
//        }
//        return returnView
//    }
//}


class SearchSchoolViewController: UIViewController {
    
    var searchView: SearchView!
    
    var clouser: ((String)->())?
    
    var schoolList = [SchoolData]() {
        didSet {
            if schoolList.isEmpty {
                
            }
            else {
                
            }
            schoolTableView.reloadData()
        }
    }
    
    @IBOutlet weak var schoolTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingSearchView()
        schoolTableView.register(UINib(nibName: "SchoolTableViewCell", bundle: nil), forCellReuseIdentifier: "schoolCell")
        schoolTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        searchSchool("")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func settingSearchView() {
        let naviFrame = navigationController!.navigationBar.frame
        searchView = SearchView(frame: .init(origin: .zero, size: CGSize(width: naviFrame.width, height: naviFrame.height)))
        searchView.delegate = self
        let rightBarBtn = UIBarButtonItem(customView: searchView)
        navigationItem.rightBarButtonItem = rightBarBtn
        
    }
    
}

extension SearchSchoolViewController: SearchViewDelegate {
    func chageText(_ text: String) {
        searchSchool(text)
    }
}

extension SearchSchoolViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell", for: indexPath) as! SchoolTableViewCell
        cell.initView(schoolList[indexPath.item])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard clouser != nil else {
            return
        }
        let school = schoolList[indexPath.item]
        clouser!("\(school.name ?? "미확인") (\(school.number ?? "0000"))")
        self.navigationController?.popViewController(animated: true)
    }
}


extension SearchSchoolViewController {
    func searchSchool(_ text: String) {
        let parameters = [
            "name": text
        ] as [String:Any]
        ServerUtil.shared.getSchool(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["school"] as? NSArray else {
                return
            }
            
            self.schoolList = array.compactMap { SchoolData($0 as! NSDictionary) }
        }
    }
}
