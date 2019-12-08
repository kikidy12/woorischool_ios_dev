//
//  AlarmData.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import Foundation
import UIKit

struct AlarmData {
    
    var id: Int!
    var title: String!
    var type: String!
    var userId: Int!
    var content: String!
    var time: String!
    
    
    init() {
    }
    
    init(data: NSDictionary) {
        id = data["id"] as? Int
        title = data["title"] as? String
        type = data["type"] as? String
        userId = data["user_id"] as? Int
        content = data["content"] as? String
        time = data["time"] as? String
    }
}
