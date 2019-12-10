//
//  ChattingRoomListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChattingRoomListViewController: UIViewController {
    
    var chattingRoomList = [ChatRoomData]() {
        didSet {
            if chattingRoomList.isEmpty {
                
            }
            else {
                
            }
            
            chattingRoomTableView.reloadData()
        }
    }
    
    var chatType: ChatType = .manyToMany
    
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var chattingRoomTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        chattingRoomTableView.register(UINib(nibName: "ChattingRoomTableViewCell", bundle: nil), forCellReuseIdentifier: "roomCell")
        chattingRoomTableView.tableFooterView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        setTableHeaderView()
    }
    
    func setTableHeaderView() {
        let headerView = ChattingRoomTableHeaderView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 95))
        headerView.manageColuser = {
            
        }
        headerView.timeInfoLabel.text = "채팅 가능시간 12:00pm - 3:00 pm"
        if UserDefs.lastUserType == UserType.teacher.rawValue {
            headerView.manageTimeBtn.isHidden = false
        }
        else {
            headerView.manageTimeBtn.isHidden = true
        }
        
        if chatType == .manyToMany {
            chattingRoomTableView.tableHeaderView = UIView(frame: .init(x: 0, y: 0, width: 0, height: 0.001))
        }
        else {
            chattingRoomTableView.tableHeaderView = headerView
        }
        
        getCharringRoom()
    }
    
    @IBAction func selectHeaderTabEvent(_ sender: UIButton) {
        if sender.superview!.tag == 0 {
            settingTagBar(view: sender.superview!, deselectView: headerStackView.arrangedSubviews.last(where: {$0.tag == 1})!)
        }
        else if sender.superview!.tag == 1 {
            settingTagBar(view: sender.superview!, deselectView: headerStackView.arrangedSubviews.last(where: {$0.tag == 0})!)
        }
    }
    
    func settingTagBar(view: UIView, deselectView: UIView) {
        if let btn = view.subviews.first(where: { $0 is UIButton }) as? UIButton, let lineView = view.subviews.last {
            btn.setTitleColor(.greenishTeal, for: .normal)
            lineView.isHidden = false
        }
        
        if let btn = deselectView.subviews.first(where: { $0 is UIButton }) as? UIButton, let lineView = deselectView.subviews.last {
            btn.setTitleColor(.brownGrey, for: .normal)
            lineView.isHidden = true
        }
        
        if view.tag == 0 {
            chatType = .manyToMany
        }
        
        else if view.tag == 1 {
            chatType = .oneToOne
        }
        setTableHeaderView()
        
        
    }

}

extension ChattingRoomListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chattingRoomList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! ChattingRoomTableViewCell
        cell.initView(chattingRoomList[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChattingViewController()
        vc.room = chattingRoomList[indexPath.item]
        show(vc, sender: nil)
    }
}

extension ChattingRoomListViewController {
    func getCharringRoom() {
        let parameters = [
            "type": chatType.rawValue
        ] as [String:Any]
        ServerUtil.shared.getNote(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["note"] as? NSArray else {
                return
            }
            
            self.chattingRoomList = array.compactMap { ChatRoomData($0 as! NSDictionary) }
            
        }
    }
}
