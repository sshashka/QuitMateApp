//
//  DateComponents+Extension.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.04.2023.
//

import Foundation

extension DateComponents {
    func toSting() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.year, .month, .day]
        return formatter.string(for: self)!
    }
}


extension Date {
    func toDateComponents(neededComponents: Set<Calendar.Component>) -> DateComponents {
        let calendar = Calendar.current
        return calendar.dateComponents(neededComponents, from: self)
    }
    
    static func checkIfArrayContainsToday(array: [Date]) -> Bool {
        let currentDate = Date.now
        let containsToday = array.contains { date in
            Calendar.current.isDate(date, inSameDayAs: currentDate)
        }
        return !containsToday
    }
}
