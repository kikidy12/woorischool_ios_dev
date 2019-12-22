//
//  BoardDetailViewController.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardDetailViewController: UIViewController {
    
    var board: BoardData!
    
    var isScrollToBottom = false
    
    var isTableViewUpdate = false
    
    var selectedEmoticon: ImageData!
    
    var commentList = [ReplyData]() {
        didSet {
            if commentList.isEmpty {
                
            }
            else {
                
            }
            self.replyTableView.reloadData()
            self.replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
            self.view.layoutIfNeeded()
            self.replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
            
            if isScrollToBottom {
                let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height)
                scrollView.setContentOffset(bottomOffset, animated: false)
                isScrollToBottom = false
            }
        }
    }
    
    
    
    var rightBarBtnItem = UIBarButtonItem()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var tempEmoView: UIView!
    @IBOutlet weak var tempEmoImageView: UIImageView!
    @IBOutlet weak var customInputView: CustomInputView!
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var replyTableView: UITableView!
    @IBOutlet weak var replyTableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageCountLabel: UILabel!
    @IBOutlet weak var replyCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var boardImageCollectionView: UICollectionView!
    @IBOutlet weak var imageContainerView: UIView!
    
    @IBOutlet weak var likeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        replyTableView.register(UINib(nibName: "BoardReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "replyCell")
        replyTableView.estimatedRowHeight = 300
        replyTableView.rowHeight = UITableView.automaticDimension
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGesture.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGesture)
        customInputView.parentsVc = self
        customInputView.delegate = self
        boardImageCollectionView.register(UINib(nibName: "ImagePagingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        settingNaviBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getBoard()
        getReplyList()
        getEmoticon()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func hideTempEmoView() {
        tempEmoView.isHidden = true
    }
    
    @IBAction func likeCheckEvent() {
        likeCheck()
    }
    
    func settingNaviBar() {
        rightBarBtnItem = UIBarButtonItem(image: UIImage(named:"moreIcon"), style: .plain, target: self, action: #selector(showActionSheet))
        if board?.postingUser?.id == GlobalDatas.currentUser.id {
            navigationItem.rightBarButtonItem = rightBarBtnItem
        }
    }
    
    func setLike(isLike: Bool) {
        if isLike {
            likeImageView.image = UIImage(named: "heartfillIcon")
        }
        else {
            likeImageView.image = UIImage(named: "heartemptycon")
        }
    }
    
    @objc func hideKeyBoard() {
        customInputView.lastSelectTextView.resignFirstResponder()
    }
    
    @objc func showActionSheet() {
        let bottomSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "수정하기", style: .default) { (_) in
            let vc = BoardAddAndEditViewController()
            vc.board = self.board
            self.show(vc, sender: nil)
        }
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { (_) in
            AlertHandler().showAlert(vc: self, message: "삭제하시겠습니까?", okTitle: "삭제", cancelTitle: "취소", okHandler: { (_) in
                self.deleteBoard()
            })
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (_) in
            
        }
        
        cancelAction.setValue(UIColor.red, forKey: "titleTextColor")
        bottomSheet.addAction(editAction)
        bottomSheet.addAction(deleteAction)
        bottomSheet.addAction(cancelAction)

        
        self.present(bottomSheet, animated: true, completion: nil)
    }
    
    func settingBoard() {
        nameLabel.text = board.postingUser.name
        timeLabel.text = board.writeTime
        contentLabel.text = board.content?.decodeEmoji
        replyCountLabel.text = "댓글 (\(board.commentCount ?? 0))"
        likeCountLabel.text = "+\(board.likeCount ?? 0)"
        
        if board.imageList.count == 0 {
            imageContainerView.isHidden = true
            imageCountLabel.isHidden = true
        }
        else if board.imageList.count == 1 {
            imageContainerView.isHidden = false
            imageCountLabel.isHidden = true
        }
        else {
            imageContainerView.isHidden = false
            imageCountLabel.text = "\(1)/\(board.imageList.count)"
            imageCountLabel.isHidden = false
        }
        setLike(isLike: board.isLike)
        boardImageCollectionView.reloadData()
    }
}
extension BoardDetailViewController: CustomInputViewDelegate {
    
    func sendMessage(message: String, image: UIImage?) {
        if !tempEmoView.isHidden, let emo = selectedEmoticon {
            print("isEmoticon")
            addReply(message: message, image: nil, emoticon: emo)
        }
        else if image != nil {
            print("isImage")
            addReply(message: message, image: image, emoticon: nil)
        }
        else {
            print("onlyMessage")
            addReply(message: message, image: nil, emoticon: nil)
        }
    }
    
    func keyboardSizeChange(height: CGFloat) {
        if height == 0 {
            tempEmoView.isHidden = true
            self.chatViewBottomConstraint.constant = 0
        }
        else {
            UIView.animate(withDuration: 1) {
                self.chatViewBottomConstraint.constant = height - self.view.safeAreaInsets.bottom
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func selectEmoticon(emoticon: ImageData) {
        self.selectedEmoticon = emoticon
        tempEmoImageView.kf.setImage(with: emoticon.url)
        self.tempEmoView.isHidden = false
    }
}

extension BoardDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! BoardReplyTableViewCell
        cell.initView(commentList[indexPath.item])
        cell.showReReListClouser = {
            let vc = ReplyListViewController()
            vc.parentReply = self.commentList[indexPath.item]
            self.show(vc, sender: nil)
        }
        
        cell.deleteClouser = {
            self.deleteReply(id: self.commentList[indexPath.item].id!)
        }
        return cell
    }
}

extension BoardDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImagePagingCollectionViewCell
        cell.boardImageView.kf.setImage(with: board.imageList[indexPath.item].url, placeholder: UIImage(named: "tempImage"))
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        boardImageCollectionView.visibleCells.forEach {
            imageCountLabel.text = "\(boardImageCollectionView.indexPath(for: $0)!.item + 1)/\(board.imageList.count)"
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //        return (collectionView.frame.width - 304)
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //        return .init(width: 304, height: collectionView.frame.height)
        return .init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //        let padding = (collectionView.frame.width - 304) / 2
        //        return .init(top: 0, left: padding, bottom: 0, right: padding)
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PhotoDetailShowViewViewController()
        vc.imageList = board.imageList
        vc.index = indexPath.item
        showPopupView(vc: vc)
    }
    
}

extension BoardDetailViewController {
    func getReplyList() {
        let parameters = [
            "board_id": board.id!
        ] as [String:Any]
        ServerUtil.shared.getV2Comment(self, parameters: parameters) { (success, dict, message) in
            guard success, let array = dict?["comment"] as? NSArray else {
                return
            }
            
            self.commentList = array.compactMap { ReplyData($0 as! NSDictionary) }
            
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
    
    func addReply(message: String, image: UIImage?, emoticon: ImageData?) {
        ServerUtil.shared.putV2Comment(vc: self, multipartFormData: { (formData) in
            formData.append("\(self.board.id!)".data(using: .utf8)!, withName: "board_id")
            formData.append(message.data(using: .nonLossyASCII, allowLossyConversion: true)!, withName: "content")
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
            self.isScrollToBottom = true
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
    
    func deleteBoard() {
        let parameters = [
            "board_id": board.id!
        ] as [String:Any]
        
        ServerUtil.shared.deleteV2Board(self, parameters: parameters) { (success, dict, message) in
            guard success else {
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func getBoard() {
        let parameters = [
            "board_id": board.id!
        ] as [String:Any]
        
        ServerUtil.shared.postv2BoardDetail(self, parameters: parameters) { (success, dict, message) in
            guard success, let data = dict?["board"] as? NSDictionary else {
                return
            }
            self.board = BoardData(data)
            self.settingBoard()
        }
    }
    
    func likeCheck() {
        let parameters = [
            "board_id": board.id!
        ] as [String:Any]
        ServerUtil.shared.postLike(self, parameters: parameters) { (success, dict, message) in
            guard success, let isLike = dict?["is_like"] as? Bool, let likeCount = dict?["like_count"] as? Int else {
                return
            }
            self.setLike(isLike: isLike)
            self.likeCountLabel.text = "+\(likeCount)"
        }
    }
}

