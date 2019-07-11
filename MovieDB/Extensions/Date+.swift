//
//  Date+.swift
//  MovieDB
//
//  Created by kazutaka.ando on 2019/07/09.
//  Copyright © 2019 Kazando. All rights reserved.
//

import UIKit

extension DateFormatter {
    static let defaultCalendar = Calendar(identifier: Calendar.Identifier.gregorian)
    static let defaultLocale = Locale(identifier: "en_US_POSIX")
    static let japaneseLocale = Locale(identifier: "ja_JP")
    
    enum Format: String {
        case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case date = "yyyy-MM-dd"
        
        var instance: DateFormatter {
            switch self {
            default:
                return DateFormatter().then {
                    $0.dateFormat = self.rawValue
                    $0.calendar = DateFormatter.defaultCalendar
                    $0.locale = DateFormatter.defaultLocale
                }
            }
        }
        
        var japaneseInstance: DateFormatter {
            switch self {
            default:
                return DateFormatter().then {
                    $0.dateFormat = self.rawValue
                    $0.calendar = DateFormatter.defaultCalendar
                    $0.locale = DateFormatter.japaneseLocale
                }
            }
        }
    }
}

extension Date {
    func dateString() -> String {
        return DateFormatter.Format.date.instance.string(from: self)
    }
    
    static func date(day: Int, month: Int, year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return DateFormatter.defaultCalendar.date(from: dateComponents)
    }
}

extension Date {
    func toString(dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

