//
//  LectureClassDayData.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureClassDayData: NSObject {
    
    let dateformatter = DateFormatter()
    let timeFormatter = DateFormatter()

    var id: Int!
    var day: String!
    var startTime: Date!
    var endTime: Date!
    
    var eduTime: String {
        timeFormatter.dateFormat = "HH:mm"
        guard let sTime = startTime, let eTime = endTime  else {
            return "미확인"
        }
        
        return "\(timeFormatter.string(from: sTime))-\(timeFormatter.string(from: eTime))"
    }
    
    var lectureClass: LectureClassData!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        dateformatter.dateFormat = "HH:mm:ss"
        id = data["id"] as? Int
        day = data["day"] as? String
        if let str = data["start_time"] as? String {
            startTime = dateformatter.date(from: str)
        }
        
        if let str = data["end_time"] as? String {
            endTime = dateformatter.date(from: str)
        }
        
        if let dict = data["lecture_class"] as? NSDictionary {
            lectureClass = LectureClassData(dict)
        }
    }
}
