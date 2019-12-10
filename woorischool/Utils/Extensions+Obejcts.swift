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
    func dateToString(formatter:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = formatter
        
        return dateForamtter.string(from: self)
    }
}

extension String {
    func stringToDate(formatter:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        let dateForamtter = DateFormatter()
        dateForamtter.dateFormat = formatter
        return dateForamtter.date(from: self)
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

  @nonobjc class var grapefruit10: UIColor {
    return UIColor(red: 242.0 / 255.0, green: 103.0 / 255.0, blue: 100.0 / 255.0, alpha: 0.1)
  }

  @nonobjc class var black60: UIColor {
    return UIColor(white: 0.0, alpha: 0.6)
  }

  @nonobjc class var whiteTwo: UIColor {
    return UIColor(white: 245.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var veryLightPinkThree: UIColor {
    return UIColor(white: 230.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var iceBlue: UIColor {
    return UIColor(red: 233.0 / 255.0, green: 243.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var whiteThree: UIColor {
    return UIColor(white: 247.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var dodgerBlue: UIColor {
    return UIColor(red: 50.0 / 255.0, green: 157.0 / 255.0, blue: 1.0, alpha: 1.0)
  }

  @nonobjc class var paleGreyThree: UIColor {
    return UIColor(red: 245.0 / 255.0, green: 246.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var ice: UIColor {
    return UIColor(red: 228.0 / 255.0, green: 248.0 / 255.0, blue: 241.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var turquoiseBlue: UIColor {
    return UIColor(red: 18.0 / 255.0, green: 182.0 / 255.0, blue: 215.0 / 255.0, alpha: 1.0)
  }

  @nonobjc class var blueGrey: UIColor {
    return UIColor(red: 124.0 / 255.0, green: 133.0 / 255.0, blue: 151.0 / 255.0, alpha: 1.0)
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

extension UIImage {
    
    func resizeImage(width: CGFloat) -> Data? {
        let size = self.size
        let ratio = width / size.width
        if size.width < width {
            return self.jpegData(compressionQuality: 1.0)
        }
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage?.jpegData(compressionQuality: 1.0)
    }
}

extension Collection {

    subscript(optional i: Index) -> Iterator.Element? {
        return self.indices.contains(i) ? self[i] : nil
    }

}
