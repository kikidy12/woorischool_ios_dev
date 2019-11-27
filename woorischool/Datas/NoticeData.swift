//
//  NoticeData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/21.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class NoticeData: NSObject {
    var id : Int!
    var title: String!
    var content: String!
    var type: String!
    var cretedAt: Date!
    var updatedAt: Date!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        title = data["title"] as? String
        content = data["content"] as? String
        type = data["type"] as? String
    }
}
