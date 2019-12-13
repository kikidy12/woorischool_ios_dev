//
//  ChattingViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/08.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChattingViewController: UIViewController {
    
    var room: ChatRoomData!
    
    var verticalContentOffset:CGFloat = 0
    
    var isFirst = true
    
    var topLoadData = false
    
    var scrolltoBottm = false
    
    var isScrollBottm = false
    
    var isUpdate = false
    
    var selectedEmoticon: ImageData!
    
    var keyboardHeight:CGFloat = 0
    
    var chatList = [ChatData]()
    
    var noteMessageId: Int?

    var timer: Timer!

    @IBOutlet weak var customInputView: CustomInputView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var tempEmoView: UIView!
    @IBOutlet weak var tempEmoImageView: UIImageView!
    @IBOutlet weak var customInputViewBottomConstraint: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        chatTableView.addGestureRecognizer(tapGesture)
        
        customInputView.delegate = self
        customInputView.isCahtting = true
        customInputView.parentsVc = self
        getEmoticon()
        
        chatTableView.register(UINib(nibName: "OtherChattingTableViewCell", bundle: nil), forCellReuseIdentifier: "otherCell")
        chatTableView.register(UINib(nibName: "MyChattingTableViewCell", bundle: nil), forCellReuseIdentifier: "myCell")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if timer != nil, timer.isValid {
            timer.invalidate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if chatList.isEmpty {
            self.getChatting("new", id: -1)
        }
        if (timer == nil || !timer.isValid) {
            timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
                if self.isUpdate {
                    if let id = self.chatList.last?.id {
                        self.getChatting("new", id: id)
                    }
                    else {
                        self.getChatting("new", id: -1)
                    }
                }
                
            }
        }
    }
    
    @IBAction func hideTempEmoView() {
        self.tempEmoView.isHidden = true
    }
    

    @objc func hideKeyBoard() {
        customInputView.lastSelectTextView.resignFirstResponder()
    }
}

extension ChattingViewController: CustomInputViewDelegate {
    
    func sendMessage(message: String, image: UIImage?) {
        if !tempEmoView.isHidden, let emoticon = selectedEmoticon {
            addChat(message: message, image: image, emoticon: emoticon)
        }
        else if image != nil {
            addChat(message: message, image: image, emoticon: nil)
        }
        else {
            addChat(message: message, image: nil, emoticon: nil)
        }
    }
    
    func selectEmoticon(emoticon: ImageData) {
        self.selectedEmoticon = emoticon
        tempEmoImageView.kf.setImage(with: emoticon.url)
        self.tempEmoView.isHidden = false
    }
    
    func keyboardSizeChange(height: CGFloat) {
        if height == 0 {
            self.tempEmoView.isHidden = true
            self.customInputViewBottomConstraint.constant = 0
            if self.chatTableView.contentOffset.y - self.keyboardHeight + self.view.safeAreaInsets.bottom >= 0 {
                self.chatTableView.contentOffset.y = self.chatTableView.contentOffset.y - self.keyboardHeight + self.view.safeAreaInsets.bottom
            }
        }
        else {
            UIView.animate(withDuration: 0, animations: {
                self.keyboardHeight = height
                self.customInputViewBottomConstraint.constant = height - self.view.safeAreaInsets.bottom
                
                self.chatTableView.contentOffset.y = self.chatTableView.contentOffset.y + self.keyboardHeight - self.view.safeAreaInsets.bottom
                print(self.chatTableView.contentOffset)
                self.view.layoutIfNeeded()
            })
        }
    }
}

extension ChattingViewController: UITableViewDelegate, UITableViewDataSource, UISceneDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chat = chatList[indexPath.item]
        if chat.user.id == GlobalDatas.currentUser.id {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyChattingTableViewCell
            if let preChat = chatList[optional: indexPath.item - 1], preChat.user.id == chat.user.id {
                cell.hasPre = true
            }
            else {
                cell.hasPre = false
            }
            if let nextChat = chatList[optional: indexPath.item + 1], nextChat.user.id == chat.user.id {
                cell.hasNext = true
            }
            else {
                cell.hasNext = false
            }
            cell.initView(chat)
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "otherCell", for: indexPath) as! OtherChattingTableViewCell
            
            let chat = chatList[indexPath.item]
            if let preChat = chatList[optional: indexPath.item - 1], preChat.user.id == chat.user.id {
                cell.hasPre = true
            }
            else {
                cell.hasPre = false
            }
            if let nextChat = chatList[optional: indexPath.item + 1], nextChat.user.id == chat.user.id {
                cell.hasNext = true
            }
            else {
                cell.hasNext = false
            }
            cell.initView(chat)
            return cell
        }
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height + 50 {
//            print(" you reached end of the table")
            isScrollBottm = true
        }
        else {
//            print(" you not reached end of the table")
            isScrollBottm = false
        }
        
        if scrollView.contentOffset.y < -50 {
            topLoadData = true
        }
        
        if scrollView.contentOffset.y > -10, topLoadData {
            print("isBounce true")
            topLoadData = false
            if let id = self.chatList.first?.id {
                self.getChatting("prev", id: id)
            }
        }
    }
}

extension ChattingViewController {
    func getEmoticon() {
        ServerUtil.shared.getV2Emoticon(self) { (success, dict, message) in
            guard success, let array = dict?["emoticon"] as? NSArray else {
                return
            }
            self.customInputView.emoInPutView.emoItemList = array.compactMap { ImageData($0 as! NSDictionary) }
        }
    }
    
    func getChatting(_ type: String, id: Int) {
        isUpdate = false
        let parameters = [
            "note_id": room.id!,
            "type": type,
            "note_message_id": id
        ] as [String:Any]
        print(parameters)
        ServerUtil.shared.postNote(self, parameters: parameters) { (success, dict, message) in
            self.isUpdate = true
            guard success, let array = dict?["note_message"] as? NSArray else {
                return
            }
            
            if type == "prev" {
                array.forEach {
                    self.chatList.insert(ChatData($0 as! NSDictionary), at: 0)
                }
            }
            else {
                array.forEach {
                    self.chatList.append(ChatData($0 as! NSDictionary))
                }
            }
            
            self.chatTableView.reloadData()
            if self.isFirst || self.scrolltoBottm || self.isScrollBottm, !self.chatList.isEmpty {
                print("scroll To Bottom")
                self.view.layoutIfNeeded()
                self.chatTableView.scrollToRow(at: IndexPath(item: self.chatList.count - 1, section: 0), at: .bottom, animated: false)
                if self.isFirst {
                    self.isScrollBottm = true
                }
                self.isFirst = false
                self.scrolltoBottm = false
            }
            
        }
    }
    
    func addChat(message: String, image: UIImage?, emoticon: ImageData?) {
        isUpdate = false
        ServerUtil.shared.putNote(vc: self, multipartFormData: { (formData) in
            formData.append("\(self.room.id!)".data(using: .utf8)!, withName: "note_id")
            formData.append(message.data(using: .nonLossyASCII, allowLossyConversion: true)!, withName: "message")
            if let id = emoticon?.id {
                formData.append("\(id)".data(using: .utf8)!, withName: "emoticon_id")
            }
            if let image = image {
                formData.append(image.resizeImage(width: 300)!, withName: "image", fileName: "commentImage.jpeg", mimeType: "image/jpeg")
            }
        }) { (success, dict, message) in
            self.isUpdate = true
            guard success else {
                return
            }
            self.scrolltoBottm = true
            if self.chatList.isEmpty {
                self.getChatting("new", id: -1)
            }
            else if let id = self.chatList.last?.id {
                self.getChatting("new", id: id)
            }
        }
    }
}
