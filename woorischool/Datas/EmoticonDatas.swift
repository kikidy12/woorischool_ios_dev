//
//  EmoticonDatas.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/03.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit

class EmoticonDatas: NSObject {
    
    var id: Int!
    var image: UIImage!
    var imageURL: String!
    
    override init() {
        
    }
    
    init(id: Int, image: UIImage = UIImage(), imageURL:String = "") {
        self.id = id
        self.image = image
        self.imageURL = imageURL
    }
    
    init(_ data: NSDictionary) {
        
    }

}
