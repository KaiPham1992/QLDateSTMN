//
//  ProductEntity.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 11/3/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import ObjectMapper
import FirebaseAuth

class ProductEntity: BaseEntity {
    var id: String?
    var name: String?
    var user: String?
    var dateCheck: UInt64?
    var dateExpire: UInt64?
    var image: String?
    
    var expireId: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.name <- map["name"]
        self.user <- map["user"]
        self.dateCheck <- map["date_check"]
        self.dateExpire <- map["date_expire"]
    }
    
    convenience init(id: String?, name: String, dateCheck: UInt64?, dateExpire: UInt64) {
        self.init()
        self.id = id
        self.name = name
        self.dateCheck = dateCheck
        self.dateExpire = dateExpire
        
        self.user = Auth.auth().currentUser?.email&
    }
}
