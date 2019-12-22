//
//  ManageChildrenViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/15.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ManageChildrenViewController: UIViewController {
    
    var childList = [UserData]() {
        didSet {
            if childList.isEmpty {
                
            }
            else {
                
            }
            
            childrenTableVidew.reloadData()
        }
    }
    
    @IBOutlet weak var childrenTableVidew: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navibarSetting()
        
        childrenTableVidew.delegate = self
        childrenTableVidew.dataSource = self
        childrenTableVidew.register(UINib(nibName: "ChildTableViewCell", bundle: nil), forCellReuseIdentifier: "childCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        getChildren()
    }
    
    func navibarSetting() {
        let addBtn = UIBarButtonItem(image: UIImage(named: "addIcon"), style: .plain, target: self, action: #selector(showAddChildView))
        
        navigationItem.rightBarButtonItems = [addBtn]
    }
    

    @objc func showAddChildView() {
        let vc = RegistChildViewController()
        vc.preVC = self
        show(vc, sender: nil)
    }
}

extension ManageChildrenViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "childCell", for: indexPath) as! ChildTableViewCell
        cell.initView(childList[indexPath.item])
        cell.deleteClouser = {
            self.deleteChildren(id: self.childList[indexPath.item].id!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectChild(id: childList[indexPath.item].id)
    }
    
}

extension ManageChildrenViewController {
    func getChildren() {
        ServerUtil.shared.getParentStudent(self) { (success, dict, message) in
            guard success, let array = dict?["children"] as? NSArray else {
                return
            }
            
            self.childList = array.compactMap { UserData($0 as! NSDictionary) }
        }
    }
    
    func deleteChildren(id: Int) {
        let parameters = [
            "user_id": id
        ] as [String:Any]
        ServerUtil.shared.deleteParentStudent(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler().showAlert(vc: self, message: message ?? "serverError", okTitle: "확인")
                return
            }
            
            self.getChildren()
        }
    }
    
    func selectChild(id: Int) {
        let parameters = [
            "user_id": id
        ] as [String:Any]
        ServerUtil.shared.patchParentStudent(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                AlertHandler().showAlert(vc: self, message: message ?? "serverError", okTitle: "확인")
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
}
