//
//  MessageDatas.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/03.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class MessageDatas: NSObject {
    
    var id: Int!
    var message: String!
    var image: UIImage!
    var imageURL: String!
    var emoticon: EmoticonDatas?
    
    override init() {
        
    }
    
    init(id: Int, message: String, image: UIImage = UIImage(), imageURL: String = "", emoticon: EmoticonDatas? = nil) {
        self.id = id
        self.message = message
        self.image = image
        self.imageURL = imageURL
        self.emoticon = emoticon
    }
    
    init(_ data: NSDictionary) {
        
    }
}
