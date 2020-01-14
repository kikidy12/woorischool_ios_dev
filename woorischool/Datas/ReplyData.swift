//
//  ReplyData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/18.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ReplyData: NSObject {
    var id: Int!
    var content: String!
    var parentsId: Int!
    var imageUrl: URL!
    var emoticonUrl: URL!
    
    var writeTime: String!
    var reCommentCount: Int!
    
    var boardId: Int!
    var allBoardId: Int!
    
    var commentUser: UserData!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        content = data["content"] as? String
        boardId = data["board_id"] as? Int
        writeTime = data["write_time"] as? String
        reCommentCount = data["re_comment_count"] as? Int
        parentsId = data["parents_id"] as? Int
        allBoardId = data["all_board_id"] as? Int
        if let dict = data["user"] as? NSDictionary {
            commentUser = UserData(dict)
        }
        
        if let urlStr = data["image_url"] as? String, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            self.imageUrl = url
        }
        
        if let urlStr = data["emoticon_url"] as? String, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            self.emoticonUrl = url
        }
    }
}
