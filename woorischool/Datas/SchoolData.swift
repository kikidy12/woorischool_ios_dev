//
//  SchoolData.swift
//  woorischool
//
//  Created by 권성민 on 2019/11/05.
//  Copyright © 2019 beanfactory. All rights reserved.
//

import UIKit
import NMapsMap

class SchoolData: NSObject {
    
    var id: Int!
    var name: String!
    var number: String!
    var location: NMGLatLng!
    
    override init() {
        
    }
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        name = data["name"] as? String
        number = data["number"] as? String
        if let lat = data["latitude"] as? Double, let lng = data["longitude"] as? Double {
            location = NMGLatLng(lat: lat, lng: lng)
        }
    }
}
