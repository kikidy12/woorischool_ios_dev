//
//  AcademyCategory.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/13.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit

class AcademyCategory: NSObject {
    var id: Int!
    var name: String!

    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
    }
    
    init(name: String) {
        self.name = name
    }
}
