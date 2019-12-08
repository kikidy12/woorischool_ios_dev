//
//  ReplyListViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ReplyListViewController: UIViewController {
    
    var parentReply: ReplyData!
    
    var isFirst = true
    
    var commentList = [ReplyData]() {
        didSet {
            if commentList.isEmpty {
                
            }
            else {
                
            }
            
            replyTableView.reloadData()
            self.viewWillLayoutSubviews()
            
            if isFirst {
                isFirst = false
            }
            else {
                let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height)
                scrollView.setContentOffset(bottomOffset, animated: false)
            }
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
        replyTableView.register(UINib(nibName: "BoardReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "parentsCell")
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        
        customInputView.parentsVc = self
        
        customInputView.delegate = self
        
        getEmoticon()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getReplyList()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        replyTableView.layoutIfNeeded()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
    }
    
    @objc func hideKeyBoard() {
        customInputView.lastSelectTextView.resignFirstResponder()
    }
}

extension ReplyListViewController: CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?, emoticon: ImageData?) {
        addReply(message: message, image: image, emoticon: emoticon)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "parentsCell", for: indexPath) as! BoardReplyTableViewCell
            cell.initView(commentList[indexPath.item])
            cell.isParent = true
            cell.bottomStackView.arrangedSubviews.forEach {
                if $0 != cell.timeLabel {
                    $0.isHidden = true
                }
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! ReReplyTableViewCell
            cell.initView(commentList[indexPath.item])
            cell.deleteClouse = {
                self.deleteReply(id: self.commentList[indexPath.item].id!)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ReplyListViewController {
    func getReplyList() {
        let parameters = [
            "comment_id": parentReply.id!
        ] as [String:Any]
        ServerUtil.shared.postV2Comment(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["comment"] as? NSArray else {
                return
            }
            
            self.commentList = array.compactMap { ReplyData($0 as! NSDictionary) }
            
        }
    }
    
    func addReply(message: String, image: UIImage?, emoticon: ImageData?) {
        ServerUtil.shared.putV2Comment(vc: self, multipartFormData: { (formData) in
            formData.append("\(self.parentReply.boardId!)".data(using: .utf8)!, withName: "board_id")
            formData.append("\(self.parentReply.id!)".data(using: .utf8)!, withName: "parents_id")
            formData.append(message.data(using: .utf8)!, withName: "content")
            if let id = emoticon?.id {
                formData.append("\(id)".data(using: .utf8)!, withName: "emoticon_id")
            }
            if let image = image {
                formData.append(image.resizeImage(width: 300)!, withName: "image", fileName: "commentImage.jpeg", mimeType: "image/jpeg")
            }
        }) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.getReplyList()
        }
    }
    
    func getEmoticon() {
        
        ServerUtil.shared.getV2Emoticon(self) { (success, dict, message) in
            guard success, let array = dict?["emoticon"] as? NSArray else {
                return
            }
            
            self.customInputView.emoInPutView.emoItemList = array.compactMap { ImageData($0 as! NSDictionary) }
        }
    }
    
    func deleteReply(id: Int) {
        let parameters = [
            "comment_id": id
        ] as [String:Any]
        
        ServerUtil.shared.deleteV2Comment(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.getReplyList()
        }
    }
}
