//
//  UserAPIService.swift
//  cihyn-ios
//
//  Created by Ngoc Duong on 10/10/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import Foundation

protocol UserAPIServiceProtocol {
    func ratingTech(param: RatingUserParam, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure)
}

class UserAPIService: UserAPIServiceProtocol {
    private let network: APINetworkProtocol
    
    init(network: APINetworkProtocol) {
        self.network = network
    }
    
    func ratingTech(param: RatingUserParam, success: @escaping SuccessHandler<BaseEntity>.object, failure: @escaping RequestFailure) {
        let endPoint = UserEndPoint.ratingUser(param: param)
        network.requestData(endPoint: endPoint, success: MapperData.mapNoData(success), failure: failure)
    }
}


