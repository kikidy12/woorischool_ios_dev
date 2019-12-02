//
//  ChattingRoomListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChattingRoomListViewController: UIViewController {
    
    var chattingRoomList = [String]()
    
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
        
        chattingRoomTableView.reloadData()
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
    
    func showOutgoingMessage(text: String) {
        let label =  UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = text

        let constraintRect = CGSize(width: 0.66 * view.frame.width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: label.font],
                                            context: nil)
        label.frame.size = CGSize(width: ceil(boundingBox.width),
                                  height: ceil(boundingBox.height))

        let bubbleSize = CGSize(width: label.frame.width + 28,
                                     height: label.frame.height + 20)

        let width = bubbleSize.width
        let height = bubbleSize.height

        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: width - 22, y: height))
        bezierPath.addLine(to: CGPoint(x: 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
        bezierPath.addLine(to: CGPoint(x: 0, y: 17))
        bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
        bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: width, y: 17), controlPoint1: CGPoint(x: width - 7.61, y: 0), controlPoint2: CGPoint(x: width, y: 7.61))
        bezierPath.addLine(to: CGPoint(x: width, y: height/2 - 11))
        bezierPath.addCurve(to: CGPoint(x: width + 10, y: height/2), controlPoint1: CGPoint(x: width + 4, y: height/2 - 5), controlPoint2: CGPoint(x: width + 4, y: height/2 + 5))
        bezierPath.addLine(to: CGPoint(x: width, y: height - 17))
        bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 7.61, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
        bezierPath.close()

        let outgoingMessageLayer = CAShapeLayer()
        outgoingMessageLayer.path = bezierPath.cgPath
        outgoingMessageLayer.frame = CGRect(x: view.frame.width/2 - width/2,
                                            y: view.frame.height/2 - height/2,
                                            width: width,
                                            height: height)
        outgoingMessageLayer.fillColor = UIColor(red: 0.09, green: 0.54, blue: 1, alpha: 1).cgColor

        view.layer.addSublayer(outgoingMessageLayer)

        label.center = view.center
        view.addSubview(label)
    }

}

extension ChattingRoomListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) as! ChattingRoomTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}
