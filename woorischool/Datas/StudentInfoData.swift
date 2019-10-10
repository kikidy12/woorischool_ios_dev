//
//  StudentInfoData.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/10.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class StudentInfoData: NSObject {
    
    var id: Int!
    var years: Int!
    var grade: Int!
    var classNumber: Int!
    var number: Int!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        years = data["years"] as? Int
        grade = data["grade"] as? Int
        classNumber = data["class_number"] as? Int
        number = data["number"] as? Int
    }
}
