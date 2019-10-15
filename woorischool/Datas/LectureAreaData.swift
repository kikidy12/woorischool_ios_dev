//
//  LectureAreaData.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/13.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureAreaData: NSObject {
    
    var id: Int!
    var name: String!
    
    var isSelected = false
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
    }
}
