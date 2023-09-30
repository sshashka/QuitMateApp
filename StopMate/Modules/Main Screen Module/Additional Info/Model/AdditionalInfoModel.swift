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

enum AdditionalInfoModelValueUnits {
    case money(String)
    case emissions(String)
}
/// A model representing additional information.
///
struct AdditionalInfoModel {
    /// Value that needs to be shown in additional info view
    let value: Double
    /// The type of value (monthly or daily).
    let valueType: AdditionalInfoModelValueType
    
    let valueUnit: AdditionalInfoModelValueUnits
    
    func getValueSet() -> (dailyValue: String, weeklyValue: String, monthlyValue: String, yearlyValue: String) {
        return (dailyValue: dailyValue, weeklyValue: weeklyValue, monthlyValue: monthlyValue, yearlyValue: yearlyValue)
    }
    
    // Format value to two decimal places
    func valueFormatterToTwoDecimals(_ value: Double) -> String {
        var unit = ""
        // Clean this mess in switch
        switch valueUnit {
        case .money(let string):
            unit = string
        case .emissions(let string):
            unit = string
        }
        return String(format: "%.2f", value) + unit
    }
    
    private var dailyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatterToTwoDecimals(value / 30)
        case .daily:
            return valueFormatterToTwoDecimals(value)
        }
    }
    
    private var weeklyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatterToTwoDecimals(value / 4.345 )
        case .daily:
            return valueFormatterToTwoDecimals(value * 7)
        }
    }
    
    var unitOfValue: String {
        switch valueType {
        case .monthly:
            return "uah"
        case .daily:
            return "g"
        }
    }
    
    private var monthlyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatterToTwoDecimals(value)
        case .daily:
            return valueFormatterToTwoDecimals(value * 30)
        }
    }
    
    private var yearlyValue: String {
        switch valueType {
        case .monthly:
            return valueFormatterToTwoDecimals(value * 12)
        case .daily:
            return valueFormatterToTwoDecimals(value * 365)
        }
    }
}
