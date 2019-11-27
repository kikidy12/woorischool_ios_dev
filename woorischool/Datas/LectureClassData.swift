//
//  LectureClassData.swift
//  woorischool
//
//  Created by 권성민 on 2019/10/11.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class LectureClassData: NSObject {
    
    var id: Int!
    var name: String!
    var price: Int!
    var material: String!
    var minGrade: Int!
    var maxGrade: Int!
    var classTime: String!
    var location: String!
    var maxPerson: Int!
    var applyPerson: Int!
    var waitCount: Int!
    var confirmCount: Int!
    var isTodayWrite: Bool!
    var attendance: AttendenceType!
    
    var isApply: Bool!
    
    var applyId: Int!
    
    var teacher: UserData!
    
    var lecture: LectureData!
    
    var dayList = [LectureClassDayData]()
    
    var scheduleList = [LectureScheduleData]()
    
    var lectureSchedule: LectureScheduleData!
    
    var daysStr: String {
        var weekDaysStr = ""
        dayList.forEach {
            weekDaysStr += $0.day!
            
            if $0 != dayList.last {
                weekDaysStr += "/"
            }
        }
        
        return weekDaysStr
    }
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        price = data["price"] as? Int
        material = data["material"] as? String
        minGrade = data["min_grade"] as? Int
        maxGrade = data["max_grade"] as? Int
        classTime = data["class_time_number"] as? String
        location = data["class_location"] as? String
        maxPerson = data["max_person"] as? Int
        applyPerson = data["apply_person"] as? Int
        confirmCount = data["confirm_count"] as? Int
        applyId = data["lecture_apply_id"] as? Int
        isApply = data["is_apply"] as? Bool
        waitCount = data["wait_count"] as? Int
        isTodayWrite = data["is_today_write"] as? Bool
        
        if let dict = data["lecture"] as? NSDictionary {
            lecture = LectureData(dict)
        }
        
        if let dict = data["teacher"] as? NSDictionary {
            teacher = UserData(dict)
        }
        
        if let array = data["lecture_class_day"] as? NSArray {
            dayList = array.compactMap { LectureClassDayData($0 as! NSDictionary) }
        }
        
        if let array = data["lecture_schedule"] as? NSArray {
            scheduleList = array.compactMap { LectureScheduleData($0 as! NSDictionary) }
        }
        
        if let str = data["attendance"] as? String {
            attendance = AttendenceType(rawValue: str)
        }
        
        
        if let schedule = data["schedule"] as? NSDictionary {
            lectureSchedule = LectureScheduleData(schedule)
        }
    }

    
    func gradeStr() -> String {
        return "\(minGrade ?? 0)-\(maxGrade ?? 0)"
    }
}
