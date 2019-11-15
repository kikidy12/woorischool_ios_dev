//
//  BoardDetailViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class TempMessageDatas: NSObject {
    var message: String = ""
    var image: UIImage?
    
    init(message: String, image: UIImage? = nil) {
        self.message = message
        self.image = image
    }
}

class BoardDetailViewController: UIViewController {
    
    var replyList:[TempMessageDatas] = [TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: UIImage(named: "chatUpIcon")!),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: UIImage(named: "chatUpIcon")!),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil)] {
        didSet {
            replyTableView.reloadData()
            replyTableView.layoutIfNeeded()
            replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height)
            scrollView.setContentOffset(bottomOffset, animated: false)
        }
    }
    
    var count = 10
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var customInputView: CustomInputView!
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var replyTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTableView.register(UINib(nibName: "BoardReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "replyCell")
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        customInputView.parentsVc = self
//        customInputView.chatTextViewBottomConstraint = chatTextViewBottomConstraint
        customInputView.delegate = self
    }
    
    
    override func viewWillLayoutSubviews() {
        replyTableView.layoutIfNeeded()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
    }
    
    @objc func hideKeyBoard() {
        customInputView.lastSelectTextView.resignFirstResponder()
    }
}
extension BoardDetailViewController: CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?) {
        if message.isEmpty, image == nil {
            return
        }
        else {
            replyList.append(TempMessageDatas(message: message, image: image))
        }
    }
    
    func keyboardSizeChange(height: CGFloat) {
        if height == 0 {
            chatViewBottomConstraint.constant = 0
        }
        else {
            chatViewBottomConstraint.constant = height - view.safeAreaInsets.bottom
        }
        view.updateConstraints()
    }
}

extension BoardDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return replyList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! BoardReplyTableViewCell
        if !replyList[indexPath.item].message.isEmpty {
            cell.contentLabel.isHidden = false
            cell.contentLabel.text = replyList[indexPath.item].message
        }
        else {
            cell.contentLabel.isHidden = true
        }
        if let image = replyList[indexPath.item].image {
            cell.imageContainerView.isHidden = false
            cell.messageImageView.image = image
        }
        else {
            cell.imageContainerView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReplyListViewController()
        self.show(vc, sender: nil)
    }
}
