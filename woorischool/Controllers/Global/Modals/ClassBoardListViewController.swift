//
//  ClassBoardListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/01.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ClassBoardListViewController: UIViewController {
    
    var lectureClass: LectureClassData!
    
    var boardList = [BoardData]() {
        didSet {
            if boardList.isEmpty {
                
            }
            else {
                
            }
            
            boardTableView.reloadData()
        }
    }
    
    @IBOutlet weak var boardTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boardTableView.register(UINib(nibName: "ClassBoardTableViewCell", bundle: nil), forCellReuseIdentifier: "boardCell")
        
        boardTableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        naviBarSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getClassBoardList()
    }
    
    func naviBarSetting() {
        let barBtn = UIBarButtonItem(image: UIImage(named:"addIcon"), style: .plain, target: self, action: #selector(showBoardEditView))
        
        navigationItem.rightBarButtonItem = barBtn
    }
    
    @objc func showBoardEditView() {
        let vc = BoardAddAndEditViewController()
        vc.lectureClass = self.lectureClass
        show(vc, sender: nil)
    }
}

extension ClassBoardListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "boardCell", for: indexPath) as! ClassBoardTableViewCell
        cell.initView(boardList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = BoardDetailViewController()
        vc.board = boardList[indexPath.item]
        self.show(vc, sender: nil)
    }
}


extension ClassBoardListViewController {
    func getClassBoardList() {
        let parameters = [
            "lecture_class_id": lectureClass.id!
        ] as [String: Any]
        ServerUtil.shared.postV2Board(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["board"] as? NSArray else {
                return
            }
            
            self.boardList = array.compactMap { BoardData($0 as! NSDictionary) }
        }
    }
}
