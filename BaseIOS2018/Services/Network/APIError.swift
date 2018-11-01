//
//  APIError.swift
//  Cihyn_Dev
//
//  Created by Ngoc Duong on 9/28/18.
//  Copyright © 2018 Mai Nhan. All rights reserved.
//

import UIKit

// MARK APPError
struct APPError {
    static let canNotParseData = APIError(message: "Can Not Parse Data")
}

// MARK: APIError class
class APIError: Error {
    let code: Int?
    let message: String?
    
    init(code: Int?, message: String?) {
        self.code = code
        self.message = message
    }
    
    init(message: String?) {
        self.message = message
        self.code = nil
    }
    
    init(baseResponse: BaseResponse) {
        self.code = baseResponse.status
        self.message = baseResponse.message
    }
    
    init(error: Error?) {
        self.code = nil
        self.message = error?.localizedDescription
    }
}

