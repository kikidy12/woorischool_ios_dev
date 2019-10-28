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
        self.dateFormat = "yyyy-MM-dd"
        return self.date(from: str)
    }
    
    func dateToString(_ date: Date) -> String {
        self.dateFormat = "yyyy-MM-dd"
        return self.string(from: date)
    }
    
    func stringToDateTime(_ str: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return self.date(from: str)
    }
    
}

extension Date {
    var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    func dayStringOfWeek() -> String {
        let weekday = Calendar.current.dateComponents([.weekday], from: self).weekday
        
        if weekday == 1 {
            return "일"
        }
        else if weekday == 2 {
            return "월"
        }
        else if weekday == 3 {
            return "화"
        }
        else if weekday == 4 {
            return "수"
        }
        else if weekday == 5 {
            return "목"
        }
        else if weekday == 6 {
            return "금"
        }
        else {
            return "토"
        }
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

extension String {
    var imageURL: URL? {
        guard let encoded = self.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {
            return nil
        }
        
        return URL(string: encoded) 
    }
}
