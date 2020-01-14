//
//  AcademyData.swift
//  woorischool
//
//  Created by 권성민 on 2020/01/13.
//  Copyright © 2020 beanfactory. All rights reserved.
//

import UIKit
import NMapsMap

class AcademyData: NSObject {
    var id: Int!
    var location: NMGLatLng!
    var linkUrl: String!
    var name: String!
    var address: String!
    var category: AcademyCategory!
    
    init(_ data: NSDictionary) {
        id = data["id"] as? Int
        if let lng = data["longitude"] as? Double, let lat = data["latitude"] as? Double {
            location = NMGLatLng(lat: lat, lng: lng)
        }
        
        linkUrl = data["link_url"] as? String
        name = data["name"] as? String
        address = data["address"] as? String
        
        if let dict = data["category"] as? NSDictionary {
            category = AcademyCategory(dict)
        }
    }
}
