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
    
    static var userToken: String {
        return UserDefaults.standard.string(forKey: "userToken") ?? ""
    }
    
    static func setAutoLogin(_ auto : Bool) {
        UserDefaults.standard.set(auto, forKey: "autoLogin")
    }
    
    static func setOpenedApp(_ opened : Bool) {
        UserDefaults.standard.set(opened, forKey: "startApp")
    }
    
    static func setUserToken(token: String) {
        UserDefaults.standard.set(token, forKey: "userToken")
        ServerUtil.shared.setToken(token: token)
    }
}
