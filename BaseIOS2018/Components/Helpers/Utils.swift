//
//  Utils.swift
//  GoFixCustomer
//
//  Created by Edward Nguyen on 5/15/18.
//  Copyright © 2018 gofix.vinova.sg. All rights reserved.
//

import Foundation
import UIKit
import Photos

class Utils {
    class func convertHour(string: String) -> Int? {
        let stringArr = string.components(separatedBy: ":")
        let hour    = stringArr.first
        guard let _hour = hour else { return nil }
        return Int(_hour)
    }
    
    class func checkIncreaseTabbar() -> Bool {
        return !UIDevice.current.isIphone5_8Inch()
    }
    class func calculateDayOfMonth(month: Int, year: Int) -> Int {
        switch month {
            case 1, 3, 5, 7, 8, 10, 12:
                return 31
            case 2:
                return year % 4 == 0 ? 29 : 28
            default:
                return 30
        }
    }
    
    class func hour(from value: String) -> Int? {
        let stringArr = value.components(separatedBy: ":")
        let hour    = stringArr.first
        guard let _hour = hour else { return nil }
        return Int(_hour)
    }
    
//    class func getAfterHour(timing: TimingBracket, dateSelected: Date) -> (startAfterTime: Int?, endAfterTime: Int?, startStanderTime: Int?, endStanderTime: Int?) {
//        let calendar = Calendar(identifier: .gregorian)
//        let componant = calendar.dateComponents([.weekday], from: dateSelected)
//
//        guard let weekday = componant.weekday else { return (nil, nil, nil, nil) }
//
//        let today = Utils.convert(weekday: weekday)
//
//        guard let afterHour = timing.afterHourConfiguration?.timePeriods else { return (nil, nil, nil, nil) }
//        let newAfterHour = Utils.convert(timePeriods: afterHour)
//        let periodAfterHour = newAfterHour.filter { $0.daysOfWeek == today }.first
//
//        guard let standarHour = timing.standardHourConfiguration?.timePeriods else { return (nil, nil, nil, nil) }
//        let newStandarHour = Utils.convert(timePeriods: standarHour)
//        let periodStanderHour = newStandarHour.filter { $0.daysOfWeek == today }.first
//
//        return(periodAfterHour?.startsAt, periodAfterHour?.endsAt, periodStanderHour?.startsAt, periodStanderHour?.endsAt)
//    }
//
//    class func convert(timePeriods: [TimePeriod]) -> [NewTimePeriod] {
//        var listTimePeriod = [NewTimePeriod]()
//        for timePeriod in timePeriods {
//            if let daysOfWeek = timePeriod.daysOfWeek {
//                for day in daysOfWeek {
//                    let newTime = NewTimePeriod(daysOfWeek: day, startsAt: timePeriod.startsAt, endsAt: timePeriod.endsAt)
//                    listTimePeriod.append(newTime)
//                }
//            }
//        }
//        return listTimePeriod
//    }
//
//    class func convert(weekday: Int) -> DaysOfWeek {
//        switch weekday {
//        case 1:
//            return DaysOfWeek.sunday
//        case 2:
//            return DaysOfWeek.monday
//        case 3:
//            return DaysOfWeek.tuesday
//        case 4:
//            return DaysOfWeek.wednesday
//        case 5:
//            return DaysOfWeek.thursday
//        case 6:
//            return DaysOfWeek.friday
//        case 7:
//            return DaysOfWeek.saturday
//        default:
//            return DaysOfWeek.monday
//        }
//    }
    
    class func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized: break
        case .denied, .restricted :
            //            showAlert(title: NBMessage.PhotoLibraryPermission)
            break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization() { (status) -> Void in
                switch status {
                case .authorized: break
                case .denied, .restricted: break
                case .notDetermined: break
                }
            }
        }
    }
}

extension Utils {
    class func estimateHeight(_ width: CGFloat, customFont: UIFont, str: String) -> CGFloat {
        let size = CGSize(width: width, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: customFont], context: nil)
        return estimateFrame.height
    }
    
    class func estimateWidth(_ height: CGFloat, customFont: UIFont, str: String) -> CGFloat{
        let size = CGSize(width: 1000, height: height)
        let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
        let estimateFrame = NSString(string: str).boundingRect(with: size, options: option, attributes: [NSAttributedStringKey.font: customFont], context: nil)
        return estimateFrame.width
    }
}

//extension Utils {
//    class func convert(date: Date, startTime: String, endtime: String) -> (start: Date?, end: Date?) {
//
//        var strDate = date.toString(formatString: GFDateFormat.yyyyMMdd.rawValue)
//        let strStart = "\(strDate)T\(startTime):00"
//
//        if endtime == "00:00" {
//            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
//            if let _tomorrow = tomorrow {
//                strDate = _tomorrow.toString(formatString: GFDateFormat.yyyyMMdd.rawValue)
//            }
//        }
//        let strEnd = "\(strDate)T\(endtime):00"
//
//        let startHour = Date(string: strStart, format: .ISO8601)
//        let endHour = Date(string: strEnd, format: .ISO8601)
//        
//        return (startHour, endHour)
//    }
//}
