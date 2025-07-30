//
//  Date+Ext.swift
//  Flex121
//
//  Created by Rəşad Əliyev on 7/29/25.
//

import UIKit
import Foundation

class AppDate {
    static func getDay(offset: Int = 0) -> Int {
        let calendar = Calendar.current
        let today = Foundation.Date()
        
        if let newDate = calendar.date(byAdding: .day, value: offset, to: today) {
            return calendar.component(.day, from: newDate)
        }
        
        return calendar.component(.day, from: today)
    }
    
    static func getWeekday(offset: Int = 0) -> String {
        let calendar = Calendar.current
        let today = Date()
        
        let targetDate = calendar.date(byAdding: .day, value: offset, to: today) ?? today
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "EEE"
        
        return formatter.string(from: targetDate)
    }
}
