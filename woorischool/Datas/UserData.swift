//
//  UserDatas.swift
//  woorischool
//
//  Created by 권성민 on 01/10/2019.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import Kingfisher

class UserData: NSObject {
    var id: Int!
    var type: UserType!
    var name: String!
    var phoneNum: String!
    var email: String!
    var point: Int!
    
    var profileImage: UIImage!
    
    var attendence: AttendenceType!
    
    var childlen: UserData!
    
    var studentInfo: StudentInfoData!
    
    var parentsList = [UserData]()
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        super.init()
        id = data["id"] as? Int
        name = data["name"] as? String
        email = data["email"] as? String
        phoneNum = data["phone_num"] as? String
        point = data["point"] as? Int
        if let typeStr = data["type"] as? String {
            type = UserType(rawValue: typeStr)
        }
        
        if let dict = data["child"] as? NSDictionary {
            childlen = UserData(dict)
            UserDefs.setHasChildren(true)
        }
        else {
            UserDefs.setHasChildren(false)
        }
        
        if let dict = data["student_info"] as? NSDictionary {
            studentInfo = StudentInfoData(dict)
        }
        
        if let str = data["attendance"] as? String {
            attendence = AttendenceType(rawValue: str)
        }
        
        if let array = data["parents"] as? NSArray {
            parentsList = array.compactMap { UserData($0 as! NSDictionary) }
        }
        
        if let urlStr = data["profile_image_url"] as? String, let url = URL(string: urlStr) {
            KingfisherManager.shared.retrieveImage(with: url, completionHandler: { (result) in
                switch result {
                case .success(let value):
                    self.profileImage = value.image
                    break
                case .failure(let error):
                    print(error)
                    self.profileImage = nil
                    break
                }
            })
        }
    }
}
