//
//  LectureData.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureData: NSObject {
    var id: Int!
    var name: String!
    var week: Int!
    var lecturePlanUrl: String!
    
    var lectureClass: LectureClassData!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["lecture_name"] as? String
        week = data["week"] as? Int
        lecturePlanUrl = data["lecture_plan_url"] as? String
        if let dict = data["lecture_class"] as? NSDictionary {
            lectureClass = LectureClassData(dict)
        }
    }
}
