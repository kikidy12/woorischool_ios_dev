//
//  BoardDetailViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardDetailViewController: UIViewController {
    
    var count = 10
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var chatTextView: UITextView!
    @IBOutlet weak var chatTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTextViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var replyTableViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTableView.register(UINib(nibName: "BoardReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "replyCell")
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false

        scrollView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let size = CGSize(width: chatTextView.frame.width, height: .greatestFiniteMagnitude)
        let estimatedSize = chatTextView.sizeThatFits(size)
        chatTextViewHeightConstraint.constant = estimatedSize.height
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        replyTableView.updateConstraints()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
    }
    
    
    @IBAction func registReply() {
        chatTextView.resignFirstResponder()
        count += 1
        replyTableView.reloadData()
        
        replyTableView.layoutIfNeeded()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height)
        scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.7) {
                self.chatTextViewBottomConstraint.constant = keyboardSize.height - self.view.safeAreaInsets.bottom
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(note: NSNotification) {
        self.chatTextViewBottomConstraint.constant = 0
    }
    
    @objc func hideKeyBoard() {
        chatTextView.resignFirstResponder()
    }
}

extension BoardDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude) // ---- 1
        let estimatedSize = textView.sizeThatFits(size) // ---- 2
        self.chatTextViewHeightConstraint.constant = estimatedSize.height
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
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! BoardReplyTableViewCell
        if indexPath.item % 2 == 0 {
            cell.contentLabel.text = "jkgnagmnaslkfmakdsfmkladmflkadsmflkadmfklamflamlkfmsadlkfmlkasdmflkdamfklamlkfmsadlfmls;admflkamflkadmflk;mdaf"
        }
        else {
            cell.contentLabel.text = "sdfdasfasfads"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ReplyListViewController()
        self.show(vc, sender: nil)
    }
}
