//
//  Extensions+Obejcts.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Foundation


extension DateFormatter {
    
    func showDateStr(_ date: Date, style: DateFormatterStyle = .hypoon) -> String {
        self.dateFormat = "yyyy\(style.rawValue)MM\(style.rawValue)dd"
        return self.string(from: date)
    }
    
    func stringToDate(_ str: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return self.date(from: str)
    }
    
    
}

extension UIColor {
    
    @nonobjc class var greyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var greenishTeal: UIColor {
        return UIColor(red: 44.0 / 255.0, green: 198.0 / 255.0, blue: 143.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var brownGrey: UIColor {
        return UIColor(white: 155.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var softBlue: UIColor {
        return UIColor(red: 97.0 / 255.0, green: 173.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var marigold: UIColor {
        return UIColor(red: 1.0, green: 198.0 / 255.0, blue: 0.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPink: UIColor {
        return UIColor(white: 224.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var grapefruit: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 103.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var veryLightPinkTwo: UIColor {
        return UIColor(white: 209.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var paleGrey: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 245.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    }
    
    @nonobjc class var paleGreyTwo: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 246.0 / 255.0, blue: 250.0 / 255.0, alpha: 1.0)
    }
    
}
