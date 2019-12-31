//
//  LectureApplyData.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/31.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureApplyData: NSObject {
    var id: Int!
    var status: String!
    var expireTime: Date!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        status = data["status"] as? String
        if let str = data["expire_time"] as? String {
            expireTime = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
    }
}
