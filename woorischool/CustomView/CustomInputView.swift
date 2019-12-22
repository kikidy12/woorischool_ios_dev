//
//  CustomInputView.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/03.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

protocol CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?)
    func keyboardSizeChange(height: CGFloat)
    func selectEmoticon(emoticon: ImageData)
}

extension CustomInputViewDelegate {
    
    func sendMessage(message: String, image: UIImage?) {
        
    }
    
    func keyboardSizeChange(height: CGFloat) {
        
    }
    
    func selectEmoticon(emoticon: ImageData) {
        
    }
}

class CustomInputView: UIView {
    
    var isCahtting = false
    
    var isShowKeyboard = false
    
    var defaultTextViewHeight:CGFloat = 0
    
    var selectedEmoticon: ImageData!
    var view = UIView()
    var defaultFrame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60)
    
    var emoTextView = UITextView(frame: .zero)
    
    var emoInPutView = EmoInputView(frame: .zero)
    
    var lastSelectTextView = UITextView()
    
    var keyboardHeight:CGFloat = 0
    
    var delegate: CustomInputViewDelegate?
    
    var parentsVc: UIViewController!
    var chatTextViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var messageTextView: UITextView!
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
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillChange(noti:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        defaultTextViewHeight = textViewHeightConstraint.constant
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
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @IBAction func sendMessageEvent() {
        delegate?.sendMessage(message: messageTextView.text!, image: nil)
        messageTextView.text = ""
        lastSelectTextView.resignFirstResponder()
        
        textViewHeightConstraint.constant = defaultTextViewHeight
    }
    
    @IBAction func showCameraViewEvent() {
        let vc = SelectCameraTypeViewController()
        vc.selectImagePickClouser = { image in
            self.delegate?.sendMessage(message: "", image: image)
        }
        
        parentsVc.showPopupView(vc: vc)
    }
    
    @IBAction func showEmoEvent() {
        lastSelectTextView = emoTextView
        emoTextView.becomeFirstResponder()
    }
    
    @objc func keyboardWillChange(noti: NSNotification) {
        if let keyboardSize = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if keyboardHeight != keyboardSize.height {
                delegate?.keyboardSizeChange(height: keyboardSize.height)
                keyboardHeight = keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(noti: NSNotification) {
        isShowKeyboard = false
//        tempEmoView.isHidden = true
        keyboardHeight = 0
        delegate?.keyboardSizeChange(height: 0)
    }
}

extension CustomInputView: EmoInputViewDelegate {
    func selectEmoticon(emoticon: ImageData) {
        delegate?.selectEmoticon(emoticon: emoticon)
    }
}



extension CustomInputView: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.contentSize.height >= 150.0 {
            print("150>")
            self.textViewHeightConstraint.constant = 150
        }
        else {
            let height = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .infinity)).height
            self.textViewHeightConstraint.constant = height
            print(height)
        }
        
        self.layoutIfNeeded()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lastSelectTextView = textView
    }
}


