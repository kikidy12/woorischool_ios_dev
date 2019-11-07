//
//  SchoolData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/05.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class SchoolData: NSObject {
    
    var id: Int!
    var name: String!
    var number: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        number = data["number"] as? String
    }
}
