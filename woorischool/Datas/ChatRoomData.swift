//
//  ChatData.swift
//  woorischool
//
//  Created by 권성민 on 2019/12/09.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ChatRoomData: NSObject {
    var id: Int!
    var title: String!
    var body: String!
    var lastMessageTime: String!
    var personCount: Int!
    var type: String!
    var boardIconUrl: String!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        title = data["title"] as? String
        body = data["last_message"] as? String
        lastMessageTime = data["last_message_time"] as? String
        personCount = data["person_count"] as? Int
        type = data["type"] as? String
        boardIconUrl = data["board_icon_url"] as? String
    }
}
