//
//  CustomInputView.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/03.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

protocol CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?, emoticon: ImageData?)
    func keyboardSizeChange(height: CGFloat)
}

extension CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?, emoticon: ImageData?) {
        
    }
    
    func keyboardSizeChange(height: CGFloat) {
        
    }
}

class CustomInputView: UIView {
    
    var isCahtting = false
    
    var isShowKeyboard = false
    
    var selectedEmoticon: ImageData! {
        didSet {
            emoImageView.kf.setImage(with: selectedEmoticon.url, placeholder: UIImage(named: "tempImage"))
        }
    }
    var view = UIView()
    var defaultFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
    
    var emoTextView = UITextView(frame: .zero)
    
    var emoInPutView = EmoInputView(frame: .zero)
    
    var lastSelectTextView = UITextView()
    
    var keyboardHeight:CGFloat = 0.0
    
    var delegate: CustomInputViewDelegate?
    
    var parentsVc: UIViewController!
    var chatTextViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var tempEmoView: UIView!
    @IBOutlet weak var emoImageView: UIImageView!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit(){
        view = Bundle.main.loadNibNamed("CustomInputView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        defaultFrame = self.frame
//        self.textView.frame.size = estimatedSize
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        emoInPutView.delegate = self
        textView.delegate = self
        emoTextView.inputView = emoInPutView
        emoInPutView.autoresizingMask = .flexibleHeight
        textView.keyboardDismissMode = .interactive
        emoTextView.keyboardDismissMode = .interactive
        view.addSubview(emoTextView)
        view.layoutIfNeeded()
        let height = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .infinity)).height
        self.textViewHeightConstraint.constant = height
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @IBAction func hideEmoviewEvent() {
        tempEmoView.isHidden = true
    }
    
    @IBAction func sendMessageEvent() {
        if tempEmoView.isHidden {
            delegate?.sendMessage(message: messageTextView.text!, image: nil, emoticon: nil)
        }
        else {
            delegate?.sendMessage(message: messageTextView.text!, image: nil, emoticon: selectedEmoticon)
        }
        messageTextView.text = ""
        if isCahtting {
            tempEmoView.isHidden = true
        }
        else {
            lastSelectTextView.resignFirstResponder()
        }
    }
    
    @IBAction func showCameraViewEvent() {
        let vc = SelectCameraTypeViewController()
        vc.selectImagePickClouser = { image in
            self.delegate?.sendMessage(message: "", image: image, emoticon: nil)
        }
        
        parentsVc.showPopupView(vc: vc)
    }
    
    @IBAction func showEmoEvent() {
        lastSelectTextView = emoTextView
        emoTextView.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(noti: NSNotification) {
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            if !isShowKeyboard {
                isShowKeyboard = true
                delegate?.keyboardSizeChange(height: keyboardSize.height)
            }
            
        }
    }

    @objc func keyboardWillHide(noti: NSNotification) {
        isShowKeyboard = false
        tempEmoView.isHidden = true
        delegate?.keyboardSizeChange(height: 0)
    }
}

extension CustomInputView: EmoInputViewDelegate {
    func selectEmoticon(emoticon: ImageData) {
        selectedEmoticon = emoticon
        tempEmoView.isHidden = false
    }
}



extension CustomInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let height = self.textViewHeightConstraint.constant
        if textView.contentSize.height >= 150.0 {
            self.textViewHeightConstraint.constant = 150
        }
        else {
            let height = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .infinity)).height
            self.textViewHeightConstraint.constant = height
        }
        
        self.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lastSelectTextView = textView
    }
}


