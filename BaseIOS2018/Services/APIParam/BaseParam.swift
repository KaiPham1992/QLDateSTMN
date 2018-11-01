//
//  BaseParam.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 9/30/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import ObjectMapper

class BaseParam: NSObject, Mappable {
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    override init() {
        
    }
}





//protocol BaseParam {
//    func propertyIgnored() -> [String]
//}
//
//extension BaseParam {
//    func toHttpBodyString() -> [String: Any] {
//         var parameter: [String: Any] = [:]
//
//        let mirror = Mirror(reflecting: self)
//
//        for (labelMaybe, valueMaybe) in mirror.children {
//            if let label = labelMaybe {
//                if let valueConverted = self.valueFor(property: "some", of: valueMaybe) {
//                    if !propertyIgnored().contains(label) {
//                        parameter[label] = valueConverted
//                    }
//
//                } else {
//                    if !propertyIgnored().contains(label) {
//                        parameter[label] = valueMaybe
//                    }
//                }
//            }
//        }
//
//        return parameter
//
//    }
//
//    private func isNilDescendant(_ any: Any?) -> Bool {
//        return String(describing: any) == "Optional(nil)"
//    }
//
//    private func valueFor(property:String, of object:Any) -> Any? {
//        let mirror = Mirror(reflecting: object)
//        if let child = mirror.descendant(property), !isNilDescendant(child) {
//            return child
//        }
//        else if let _obj = object as? Bool {
//            let fakeOptional: Bool? = _obj
//            return fakeOptional
//        } else {
//            return nil
//        }
//    }
//}
