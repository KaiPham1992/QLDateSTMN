//
//  String+extension.swift
//  BaseIOS2018
//
//  Created by Ngoc Duong on 10/12/18.
//  Copyright © 2018 Ngoc Duong. All rights reserved.
//

import Foundation
import UIKit

postfix operator &
let CC_SHA256_DIGEST_LENGTH   =  32

postfix func & <T>(element: T?) -> String {
    return (element == nil) ? "" : "\(element!)"
}

postfix func & <T>(element: T) -> String {
    return "\(element)"
}

extension String {
    var showLanguage: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var localized: String {
        let lang = LanguageHelper.currentAppleLanguage()
        
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func htmlDecoded()->String {
        
        guard (self != "") else { return self }
        
        var newStr = self
        // from https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
        let entities = [ //a dictionary of HTM/XML entities.
            "&quot;"    : "\"",
            "&amp;"     : "&",
            "&apos;"    : "'",
            "&lt;"      : "<",
            "&gt;"      : ">",
            "&deg;"     : "º",
            ]
        
        for (name,value) in entities {
            newStr = newStr.replacingOccurrences(of: name, with: value)
        }
        return newStr
    }
    
    func htmlEncoded()->String {
        
        guard (self != "") else { return self }
        
        var newStr = self
        // from https://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
        let entities = [ //a dictionary of HTM/XML entities.
            "&quot;"    : "\"",
            "&amp;"     : "&",
            "&apos;"    : "'",
            "&lt;"      : "<",
            "&gt;"      : ">",
            "&deg;"     : "º",
            ]
        
        for (name,value) in entities {
            newStr = newStr.replacingOccurrences(of: value, with: name)
        }
        return newStr
    }
    
    func isValidEmpty() -> Bool {
        if self.cutWhiteSpace().isEmpty {
            return true
        }
        return (self.cutWhiteSpace().trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == "")
    }
    
    func cutWhiteSpace() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}

//MARK: validate
extension String {
    func phoneString() -> String? {
        return self.replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "")
    }
    
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return hexStringFromData(input: digest(input: stringData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
    func trim() -> String{
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func isEmptyIgnoreNewLine() -> Bool {
        return self.trim().isEmpty
    }
    
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    
    
    func isValidPhone() -> Bool {
        let emailRegEx = "^(1\\-)?[0][0-9]{2,3}\\-?[0-9]{3,4}\\-?[0-9]{4,6}$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let emailRegEx1 = "^(1\\-)?[+][0-9]{2,3}\\-?[0-9]{2,3}\\-?[0-9]{3,4}\\-?[0-9]{4,6}$"
        let emailTest1 = NSPredicate(format:"SELF MATCHES %@", emailRegEx1)
        
        return emailTest.evaluate(with: self) || emailTest1.evaluate(with: self)
    }
    
    func isValidPhone2() -> Bool {
        let phoneRegEx = "^[+]?[0-9]{9,13}$"
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidLatterAndNumber() -> Bool {
        let tatterAndNumberRegEx = "^[a-zA-Z0-9]+([_ .]?[a-zA-Z0-9])*$"
        //"^[a-zA-Z0-9]*$"
        let ltatterAndNumberTest = NSPredicate(format:"SELF MATCHES %@", tatterAndNumberRegEx)
        
        return ltatterAndNumberTest.evaluate(with: self)
    }
    
    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    func attributedString(fontSize : Float) -> NSAttributedString? {
        if(self == ""){
            return nil
        }
        let oldString = String(format:"<span style=\"font-family: '-apple-system', 'HelveticaNeue'; font-size: \(fontSize)\">%@</span>", self)
        
        guard let data = oldString.data(using: String.Encoding.utf8,
                                        allowLossyConversion: false) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html,
            
            ]
        let htmlString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
        
        // Removing this line makes the bug reappear
        htmlString?.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.clear, range: NSMakeRange(0, 1))
        
        return htmlString
    }
    
    func attributedString() -> NSAttributedString? {
        if(self == ""){
            return nil
        }
        guard let data = self.data(using: String.Encoding.utf8,
                                   allowLossyConversion: false) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            NSAttributedString.DocumentReadingOptionKey.characterEncoding : String.Encoding.utf8.rawValue,
            NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html
        ]
        let htmlString = try? NSMutableAttributedString(data: data, options: options, documentAttributes: nil)
        
        // Removing this line makes the bug reappear
        htmlString?.addAttribute(NSAttributedStringKey.backgroundColor, value: UIColor.clear, range: NSMakeRange(0, 1))
        
        return htmlString
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    func toAttributedString(color: UIColor, font: UIFont? = nil, isUnderLine: Bool = false) -> NSAttributedString {
        if let font = font {
            if isUnderLine {
                return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color, NSAttributedStringKey.underlineColor: color, NSAttributedStringKey.underlineStyle: 1])
            }
            return NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
        } else {
            return NSAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: color])
        }
        
    }
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    subscript (bounds: Int) -> String {
        let start = index(startIndex, offsetBy: bounds)
        return String(self[start])
    }
}
