//
//  CustomView.swift
//  fifteensecond
//
//  Created by 권성민 on 05/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//


import UIKit

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
    @IBInspectable var borderWidth: CGFloat = 0.0 {
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
    var gradient = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.locations = [0.0, 1.0]
        gradient.colors = [UIColor.clear.cgColor, UIColor.clear.cgColor]
        self.gradient.frame = self.bounds
        self.layer.addSublayer(self.gradient)
        self.bringSubviewToFront(self.titleLabel!)
    }

    
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
            self.gradient.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    
    @IBInspectable var borderColor: UIColor = .clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var startColor: UIColor = .clear {
        didSet {
            layoutSubviews()
        }
    }

    @IBInspectable var endColor: UIColor = .clear {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        gradient.colors = [startColor.cgColor, endColor.cgColor]
    }
}


@IBDesignable
class CustomLabel: UILabel {
    
    //coner
    @IBInspectable var conerRadius : CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = self.conerRadius
        }
    }
    
    //border
    @IBInspectable var borderWidth: CGFloat = 0.0 {
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
class GradientButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

//@IBDesignable
//class CustomLabel: UILabel {
//    @IBInspectable var underLine: Bool = false {
//        didSet {
//            if underLine {
//                guard let text = text else { return }
//                let textRange = NSMakeRange(0, text.count)
//                let attributedText = NSMutableAttributedString(string: text)
//                attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
//                // Add other attributes if needed
//                self.attributedText = attributedText
//            }
//        }
//    }
//}
