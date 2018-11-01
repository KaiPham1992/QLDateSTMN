//
//  MapperData.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation
import ObjectMapper

struct MapperData {
    static func map<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkSuccess {
        return { baseResponse in
            let obj = Mapper<T>().map(JSONObject: baseResponse.data)
            successHandler(obj)
        }
    }
    
    static func mapArray<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.array) -> NetworkSuccess {
        return { baseResponse in
            let obj = Mapper<T>().mapArray(JSONObject: baseResponse.data)
            successHandler(obj!)
        }
    }
    
    static func mapNoData<T: Mappable>(_ successHandler: @escaping SuccessHandler<T>.object) -> NetworkSuccess {
        return { baseResponse in
            let objResult = Mapper<T>().map(JSONObject: baseResponse.toJSON())
           
            successHandler(objResult)
        }
    }
}
