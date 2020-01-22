//
//  RatingData.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/20.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit

class RatingData: NSObject {
    var id: Int!
    var content: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        content = data["content"] as? String
    }
}
