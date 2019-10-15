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
    
    var childlen: UserData!
    
    var studentInfo: StudentInfoData!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        phoneNum = data["phone_num"] as? String
        if let typeStr = data["type"] as? String {
            type = UserType(rawValue: typeStr)
        }
        
        if let dict = data["child"] as? NSDictionary {
            childlen = UserData(dict)
        }
        
        if let dict = data["student_info"] as? NSDictionary {
            studentInfo = StudentInfoData(dict)
        }
    }
}
