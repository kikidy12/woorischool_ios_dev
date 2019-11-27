//
//  BoardData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/18.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class BoardData: NSObject {
    var id: Int!
    var content: String!
    var commentCount: Int!
    var likeCount: Int!
    
    var writeTime: String!
    
    var imageList = [ImageData]()
    var postingUser: UserData!
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        content = data["content"] as? String
        commentCount = data["comment_count"] as? Int
        likeCount = data["like_count"] as? Int
        writeTime = data["write_time"] as? String
        
        if let dict = data["user"] as? NSDictionary {
            postingUser = UserData(dict)
        }
        
        if let array = data["board_images"] as? NSArray {
            imageList = array.compactMap { ImageData($0 as! NSDictionary) }
        }
    }
}
