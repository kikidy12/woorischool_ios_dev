//
//  UserDefs.swift
//  fifteensecond
//
//  Created by 권성민 on 12/08/2019.
//  Copyright © 2019 cfour. All rights reserved.
//


import UIKit

class UserDefs: NSObject {
    static var isAutoLogin: Bool {
        return UserDefaults.standard.bool(forKey: "autoLogin")
    }
    
    static var isOpenedApp: Bool {
        return UserDefaults.standard.bool(forKey: "startApp")
    }
    
    static var hasChildren: Bool {
        return UserDefaults.standard.bool(forKey: "hasChildren")
    }
    
    static var userToken: String {
        return UserDefaults.standard.string(forKey: "userToken") ?? ""
    }
    
    static var lastUserType: String {
        return UserDefaults.standard.string(forKey: "userType") ?? ""
    }
    
    static func setAutoLogin(_ auto : Bool) {
        UserDefaults.standard.set(auto, forKey: "autoLogin")
    }
    
    static func setOpenedApp(_ opened : Bool) {
        UserDefaults.standard.set(opened, forKey: "startApp")
    }
    
    static func setHasChildren(_ hasChildren : Bool) {
        UserDefaults.standard.set(hasChildren, forKey: "hasChildren")
    }
    
    static func setUserToken(token: String) {
        UserDefaults.standard.set(token, forKey: "userToken")
        ServerUtil.shared.setToken(token: token)
    }
    
    static func setLastUserType(type: String) {
        UserDefaults.standard.set(type, forKey: "userType")
        guard let type = UserType(rawValue: type) else { return }
        GlobalDatas.currentUserType = type
    }
}
