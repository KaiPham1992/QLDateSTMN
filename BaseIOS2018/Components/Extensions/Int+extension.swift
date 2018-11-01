//
//  Int+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import Foundation
postfix operator *

postfix func *<T>(element: T?) -> Int {
    return (element == nil) ? 0: Int("\(element!)")!
}

extension Float {
    /// Rounds the double to decimal places value
    func roundedTwoDemical() -> String {
        return String(format: "%.2f", self)
    }
}


