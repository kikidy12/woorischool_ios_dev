//
//  LectureScheduleData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/15.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureScheduleData: NSObject {
    var id: Int!
    var date: Date!
    var startTime: Date!
    var endTime: Date!
    
    var isAnnouncement: Bool = false
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        if let dateStr = data["date"] as? String {
            date = dateStr.stringToDate(formatter: "yyyy-MM-dd")
        }
        if let dateStr = data["start_time"] as? String {
            startTime = dateStr.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        if let dateStr = data["end_time"] as? String {
            endTime = dateStr.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        isAnnouncement = data["is_announcement"] as? Bool ?? false
    }
}
