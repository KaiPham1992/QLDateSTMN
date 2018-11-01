//
//  UIButton+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//


import UIKit

extension UIButton {
    func setAttributed(title: String, color: UIColor, font: UIFont?, isUnderLine: Bool = false ) {
        var attr = NSAttributedString()
        if isUnderLine {
            attr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font!, NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
        } else {
            attr = NSAttributedString(string: title, attributes: [NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.font: font!])
        }
        self.setAttributedTitle(attr, for: .normal)
    }
    
}
