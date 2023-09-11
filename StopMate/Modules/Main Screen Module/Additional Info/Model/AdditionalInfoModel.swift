//
//  AdditionalInfoModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import Foundation

enum AdditionalInfoModelValueType {
    case monthly, daily
}
/// A model representing additional information.
///
struct AdditionalInfoModel: Hashable {
    /// The value needs to be shown in additional info view
    let value: Double
    /// The type of value (monthly or daily).
    let valueType: AdditionalInfoModelValueType
    
    func getValueSet() -> (dailyValue: String, weeklyValue: String, monthlyValue: String, yearlyValue: String) {
        return (dailyValue: dailyValue, weeklyValue: weeklyValue, monthlyValue: monthlyValue, yearlyValue: yearlyValue)
    }
    
    func valueFormatter(_ value: Double) -> String {
        return String(format: "%.2f", value) // Format value to two decimal places
    }
    
    private var dailyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatter(value / 30)
        case .daily:
            return valueFormatter(value)
        }
    }
    
    private var weeklyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatter(value / 4.345 )
        case .daily:
            return valueFormatter(value * 7)
        }
    }
    
    private var monthlyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatter(value)
        case .daily:
            return valueFormatter(value * 30)
        }
    }
    
    private var yearlyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatter(value * 12)
        case .daily:
            return valueFormatter(value * 365)
        }
    }
}
