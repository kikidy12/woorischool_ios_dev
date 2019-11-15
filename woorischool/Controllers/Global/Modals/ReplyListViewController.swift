//
//  ReplyListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ReplyListViewController: UIViewController {
    
    
    var replyList:[TempMessageDatas] = [TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: UIImage(named: "chatUpIcon")!),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: UIImage(named: "chatUpIcon")!),TempMessageDatas(message: "dfsdfdsfanjfnlsf", image: nil)] {
        didSet {
            replyTableView.reloadData()
            replyTableView.layoutIfNeeded()
            replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
            let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height)
            scrollView.setContentOffset(bottomOffset, animated: false)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBOutlet weak var customInputView: CustomInputView!
    @IBOutlet weak var chatTextViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var replyTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTableView.register(UINib(nibName: "ReReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "replyCell")
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
        customInputView.parentsVc = self
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

extension ReplyListViewController: CustomInputViewDelegate {
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
            chatTextViewBottomConstraint.constant = 0
        }
        else {
            chatTextViewBottomConstraint.constant = height - view.safeAreaInsets.bottom
        }
    }
}

extension ReplyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! ReReplyTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

