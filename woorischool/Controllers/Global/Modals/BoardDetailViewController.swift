//
//  BoardDetailViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardDetailViewController: UIViewController {
    
    var replyList:[String] = ["dfsdfdsfanjfnlsf","nfjdskfndskfvnsdajfnsdkjanfkjdsfln","njdsfvndsjlfnsdjafnjksdfn","dfnjdsfndsajfndsjnfaklsdjnfjkdf","fnasdfdsfjfnwejflfa"] {
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
    @IBOutlet weak var chatTextViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var replyTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTableView.register(UINib(nibName: "BoardReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "replyCell")
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        customInputView.chatTextViewBottomConstraint = chatTextViewBottomConstraint
        customInputView.delegate = self
    }
    
    
    override func viewWillLayoutSubviews() {
        replyTableView.updateConstraints()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
    }
    
    
    func registReply() {
        count += 1
        replyTableView.reloadData()
        
        replyTableView.layoutIfNeeded()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height)
        scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    @objc func hideKeyBoard() {
        customInputView.textView.resignFirstResponder()
        customInputView.messageTextView.resignFirstResponder()
    }
}
extension BoardDetailViewController: CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?) {
        guard !message.isEmpty else {
            AlertHandler.shared.showAlert(vc: self, message: "메시지를 입력해주세요.", okTitle: "확인")
            return
        }
        
        replyList.append(message)
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
        cell.contentLabel.text = replyList[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = ReplyListViewController()
//        self.show(vc, sender: nil)
    }
}
