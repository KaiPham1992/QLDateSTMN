//
//  BranchEntity.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import ObjectMapper

class BranchEntity: BaseEntity {
    var key: String?
    var name: String?
    
    init(key: String, name: String) {
        super.init()
        self.key = key
        self.name = name
    }
    
    required init?(map: Map) {
        fatalError("init(map:) has not been implemented")
    }
}
