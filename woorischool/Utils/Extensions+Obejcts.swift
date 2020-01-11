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
    
    var decodeEmoji: String {
        let string = self.lowercased()
        let data = string.data(using: .utf8)
        if let data = data, let str = String(data: data, encoding: .nonLossyASCII) {
            return str
        }
        return self
    }
    
    var encodeEmoji: String {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)!
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


extension Int {
    var decimalString: String? {
        get {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            return numberFormatter.string(for: self)
        }
    }
}

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,4", "iPad11,5":                    return "iPad Air (3rd generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

