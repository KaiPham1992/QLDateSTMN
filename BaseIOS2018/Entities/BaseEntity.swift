//
//  BaseEntity.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseEntity: NSObject, Mappable {
    
    override init() {}
    
    required init?(map: Map) {
        super.init()
        self.mapping(map: map)
    }
    
    func mapping(map: Map) {}
    
}
