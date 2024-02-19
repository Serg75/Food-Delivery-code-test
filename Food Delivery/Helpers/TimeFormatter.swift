//
//  TimeFormatter.swift
//  Food Delivery
//
//  Created by Sergey Slobodenyuk on 2024-02-19.
//

import Foundation

struct TimeFormatter {
    static func formattedTime(minutesTotal: Int) -> String {
        let hours = minutesTotal / 60
        let minutes = minutesTotal - hours * 60
        return "\(formattedWithPlural(word: "hour", value: hours)) \(formattedWithPlural(word: "min", value: minutes))"
            .trimmingCharacters(in: .whitespaces)
    }
    
    private static func formattedWithPlural(word: String, value: Int) -> String {
        switch value {
        case 0:
            return ""
        case 1:
            return "\(value) \(word)"
        default:
            return "\(value) \(word)s"
        }
    }
}
