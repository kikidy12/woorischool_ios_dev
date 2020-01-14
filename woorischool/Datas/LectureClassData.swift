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
    var lectureApply: LectureApplyData!
    var ratingStartDate: Date!
    var ratingEndDate: Date!
    var schoolId: Int!
    var isApply: Bool!
    var grade: Int!
    var boardType: String!
    
    var applyId: Int!
    
    var teacher: UserData!
    
    var lecture: LectureData!
    
    var boardIconUrl: String!
    
    var dayList = [LectureClassDayData]()
    
    var scheduleList = [LectureScheduleData]()
    
    var lectureSchedule: LectureScheduleData!
    
    var classPeriod: String? {
        guard let lecture = self.lecture, let stDate = lecture.startDate, let edDate = lecture.endDate else {
            return nil
        }
        
        return "\(stDate.dateToString(formatter: "yyyy.MM.dd")) - \(edDate.dateToString(formatter: "yyyy.MM.dd"))"
    }
    
    var ratingPeriod: String? {
        guard let stDate = ratingStartDate, let edDate = ratingEndDate else {
            return nil
        }
        
        return "\(stDate.dateToString(formatter: "yyyy.MM.dd")) - \(edDate.dateToString(formatter: "yyyy.MM.dd"))"
    }
    
    var isStudy:Bool {
        guard let lecture = self.lecture, let edDate = lecture.endDate else {
            print("no EndDate")
            return false
        }
        
        return Date() < edDate ? true : false
    }
    
    var requestStatus: RatingRequestState = .needRequest
    
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
        schoolId = data["school_id"] as? Int
        boardType = data["type"] as? String
        grade = data["grade"] as? Int
        
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
        
        if let str = data["request_status"] as? String {
            requestStatus = RatingRequestState(rawValue: str) ?? .needRequest
        }
        
        if let str = data["rating_start_date"] as? String {
            ratingStartDate = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let str = data["rating_end_date"] as? String {
            ratingEndDate = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let dict = data["lecture_apply"] as? NSDictionary {
            lectureApply = LectureApplyData(dict)
        }
        
        boardIconUrl = data["board_icon_url"] as? String
    }

    
    func gradeStr() -> String {
        return "\(minGrade ?? 0)-\(maxGrade ?? 0)"
    }
}
