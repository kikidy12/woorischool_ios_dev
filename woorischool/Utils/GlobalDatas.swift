//
//  GlobalDatas.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/10.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Foundation

class GlobalDatas: NSObject {
    static var currentUser: UserData!
    static var deviceToken = ""
    static var currentUserType: UserType = .parents
    static var childrenList = [UserData]()
}
