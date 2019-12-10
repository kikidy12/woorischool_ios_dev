//
//  EnumObjects.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import Foundation
import UIKit

private let familyName = "NanumSquareRound"

enum DateFormatterStyle: String {
    case dot = "."
    case hypoon = "-"
}

enum ChatType: String {
    case oneToOne = "ONE"
    case manyToMany = "ALL"
}

enum UserType: String {
    case student = "STUDENT"
    case parents = "PARENTS"
    case teacher = "TEACHER"
}

enum AttendenceType: String {
    case attendance = "ATTENDANCE"
    case tardy = "TARDY"
    case absent = "ABSENT"
}

enum NanumSquareRound: String {
    case light = "Light"
    case regular = "Regular"
    case bold = "Bold"
    
    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size + 1.0) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}
