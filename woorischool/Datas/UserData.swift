//
//  UserDatas.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class UserData: NSObject {
    var id: Int!
    var type: UserType!
    var name: String!
    var phoneNum: String!
    
    var childlens = [UserData]()
    
    var studentInfo: StudentInfoData!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        if let typeStr = data["type"] as? String {
            type = UserType(rawValue: typeStr)
        }
        
        if let array = data["children"] as? NSArray {
            childlens = array.compactMap { UserData($0 as! NSDictionary) }
        }
        
        if let dict = data["student_info"] as? NSDictionary {
            studentInfo = StudentInfoData(dict)
        }
    }
}
