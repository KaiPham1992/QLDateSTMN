//
//  UserEndPoint.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/10/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//


import Alamofire

enum UserEndPoint {
    case ratingUser(param: RatingUserParam)
}

extension UserEndPoint: EndPointType {
    var path: String {
        switch self {
        case .ratingUser:
            return "user/rating"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .ratingUser:
            return .post
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .ratingUser(let param):
            return param.toJSON()
        }
    }
    
    var headers: HTTPHeaders? {
        return DefaultHeader().addAuthHeader()
    }
    
    
}
