//
//  ImageData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/15.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class ImageData: NSObject {
    var id: Int!
    var url: URL!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        if let urlStr = data["url"] as? String, let encoded = urlStr.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed), let url = URL(string: encoded) {
            self.url = url
        }
    }
}
