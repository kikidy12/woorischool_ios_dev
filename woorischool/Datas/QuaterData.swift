//
//  QuaterData.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/02.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import Foundation
import UIKit


class QuaterData: NSObject {
    var id: Int!
    var years: Int!
    var quarter: String!
    
    var startDate: Date!
    var endDate: Date!
    
    var applyEndDate: Date!
    var applyStartDate: Date!
    
    var type: QuaterType = .first
    
    var lectureClassList = [LectureClassData]()
    
    var applyPeriodStr: String {
        return "\(applyStartDate.dateToString(formatter: "yyyy.MM.dd")) - \(applyEndDate.dateToString(formatter: "yyyy.MM.dd"))"
    }
    
    var quaterPeriodStr: String {
        return "\(startDate.dateToString(formatter: "yyyy.MM.dd")) - \(endDate.dateToString(formatter: "yyyy.MM.dd"))"
    }
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        years = data["years"] as? Int
        quarter = data["quarter"] as? String
        if let str = data["start_date"] as? String {
            startDate = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let str = data["end_date"] as? String {
            endDate = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let str = data["apply_end_date"] as? String {
            applyEndDate = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let str = data["apply_start_date"] as? String {
            applyStartDate = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let array = data["lecture_class"] as? NSArray {
            lectureClassList = array.compactMap { LectureClassData($0 as! NSDictionary) }
        }
        
        if let str = data["type"] as? String {
            self.type = QuaterType(rawValue: str) ?? .first
        }
    }
}
