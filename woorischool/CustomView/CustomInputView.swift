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
}

extension CustomInputViewDelegate {
    func sendMessage(message: String, image: UIImage?) {
        
    }
}

class CustomInputView: UIView {
    
    var emoTextView = UITextView(frame: .zero)
    
    var emoInPutView = EmoInputView(frame: .zero)
    
    var lastSelectTextView = UITextView()
    
    var delegate: CustomInputViewDelegate?
    
    var vc: UIViewController!
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
        let view = Bundle.main.loadNibNamed("CustomInputView", owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        self.addSubview(view)
        
        let size = CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude)
        let estimatedSize = textView.sizeThatFits(size)
        textViewHeightConstraint.constant = estimatedSize.height
        
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow(note:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        emoInPutView.delegate = self
        emoTextView.inputView = emoInPutView
        emoInPutView.autoresizingMask = .flexibleHeight
        view.addSubview(emoTextView)
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
            delegate?.sendMessage(message: messageTextView.text!, image: nil)
        }
        else {
            delegate?.sendMessage(message: messageTextView.text!, image: emoImageView.image!)
        }
        messageTextView.text = ""
        lastSelectTextView.resignFirstResponder()
    }
    
    @IBAction func showCameraViewEvent() {
        
    }
    
    @IBAction func showEmoEvent() {
        lastSelectTextView = emoTextView
        emoTextView.becomeFirstResponder()
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.7) {
                self.chatTextViewBottomConstraint.constant = keyboardSize.height - self.superview!.safeAreaInsets.bottom
                self.superview!.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(note: NSNotification) {
        UIView.animate(withDuration: 0.3, animations: {
            self.chatTextViewBottomConstraint.constant = 0
        }) { (_) in
            self.tempEmoView.isHidden = true
        }
    }
}

extension CustomInputView: EmoInputViewDelegate {
    func selectEmoticon(image: UIImage) {
        emoImageView.image = image
        tempEmoView.isHidden = false
    }
}



extension CustomInputView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude)
        let estimatedSize = textView.sizeThatFits(size)
        self.textViewHeightConstraint.constant = estimatedSize.height
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        lastSelectTextView = textView
    }
}
