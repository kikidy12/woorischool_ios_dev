//
//  CustomView.swift
//  fifteensecond
//
//  Created by 권성민 on 05/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//


import UIKit

@IBDesignable
class BorderView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.borderColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        self.layer.cornerRadius = 7
        self.layer.borderWidth = 1
    }
    
}

@IBDesignable
class CustomView: UIView {
    
    //Shadow
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    //coner
    @IBInspectable var conerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}

@IBDesignable
class CustomButton: UIButton {
    
    //Shadow
    @IBInspectable var shadowColor: UIColor = .clear {
        didSet {
            self.layer.shadowColor = self.shadowColor.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float = 0 {
        didSet {
            self.layer.shadowOpacity = self.shadowOpacity
        }
    }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) {
        didSet {
            self.layer.shadowOffset = self.shadowOffset
        }
    }
    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            self.layer.shadowRadius = self.shadowRadius
        }
    }
    
    //coner
    @IBInspectable var conerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
}


@IBDesignable
class CustomLabel: UILabel {
    @IBInspectable var underLine: Bool = false {
        didSet {
            if underLine {
                guard let text = text else { return }
                let textRange = NSMakeRange(0, text.count)
                let attributedText = NSMutableAttributedString(string: text)
                attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
                // Add other attributes if needed
                self.attributedText = attributedText
            }
        }
    }
}
