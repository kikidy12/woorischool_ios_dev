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
    
    var rightBarBtnItem = UIBarButtonItem()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContentView: UIView!
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        replyTableView.register(UINib(nibName: "BoardReplyTableViewCell", bundle: nil), forCellReuseIdentifier: "replyCell")
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
        replyTableView.layoutIfNeeded()
        replyTableViewHeightConstraint.constant = self.replyTableView.contentSize.height
    }
    
    func settingNaviBar() {
        rightBarBtnItem = UIBarButtonItem(image: UIImage(named:"moreIcon"), style: .plain, target: self, action: #selector(showActionSheet))
        if board.postingUser.id == GlobalDatas.currentUser.id {
            navigationItem.rightBarButtonItem = rightBarBtnItem
        }
    }
    
    @objc func hideKeyBoard() {
        customInputView.lastSelectTextView.resignFirstResponder()
    }
    
    @objc func showActionSheet() {
        let bottomSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "수정하기", style: .default) { (_) in
            let vc = BoardAddAndEditViewController()
            self.isFirst = true
            vc.board = self.board
            self.show(vc, sender: nil)
        }
        let deleteAction = UIAlertAction(title: "삭제하기", style: .destructive) { (_) in
            AlertHandler.shared.showAlert(vc: self, message: "삭제하시겠습니까?", okTitle: "삭제", cancelTitle: "취소", okHandler: { (_) in
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
        contentLabel.text = board.content
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
        
        boardImageCollectionView.reloadData()
    }
}
extension BoardDetailViewController: CustomInputViewDelegate {
    
    func sendMessage(message: String, image: UIImage?, emoticon: ImageData?) {
        addReply(message: message, image: image, emoticon: emoticon)
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
        return commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "replyCell", for: indexPath) as! BoardReplyTableViewCell
        cell.initView(commentList[indexPath.item])
        cell.showReReListClouser = {
            let vc = ReplyListViewController()
            self.isFirst = true
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
}
