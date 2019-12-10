//
//  ChatData.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/09.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChatData: NSObject {
    var id: Int!
    var message: String!
    var user: UserData!
    
    var createdAt: Date!
    var imageURL: URL!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        message = data["message"] as? String
        if let dict = data["user"] as? NSDictionary {
            user = UserData(dict)
        }
        
        if let str = data["created_at"] as? String {
            createdAt = str.stringToDate(formatter: "yyyy-MM-dd HH:mm:ss")
        }
        
        if let urlStr = data["image_url"] as? String, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            self.imageURL = url
        }
        
        if let urlStr = data["emoticon_url"] as? String, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            self.imageURL = url
        }
    }
}
