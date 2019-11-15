//
//  DailyNoteData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/15.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class DailyNoteData: NSObject {
    
    var id: Int!
    var content: String!
    var homework: String!
    var materials: String!
    var writeTime: String!
    
    var lectureSchedule: LectureScheduleData!
    var imageList = [ImageData]()
    
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        content = data["content"] as? String
        homework = data["homework"] as? String
        materials = data["materials"] as? String
        writeTime = data["write_time"] as? String
        
        if let dict = data["lecture_schedule"] as? NSDictionary {
            lectureSchedule = LectureScheduleData(dict)
        }
        
        if let array = data["announcements_images"] as? NSArray {
            imageList = array.compactMap { ImageData($0 as! NSDictionary) }
        }
    }
}
