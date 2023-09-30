//
//  Localizable.swift
//  StopMate
//
//  Created by Саша Василенко on 29.09.2023.
//

import Foundation

struct Localizables {
    static let email = mainCatalog("Auth.Email")
    static let password = mainCatalog("Auth.password")
    static let passwordConfirm = mainCatalog("Auth.passwordConfirm")
    static let forgotPassword = mainCatalog("Forgot password?")
    
    
    //MARK: Charts module strings
    static let chartsWeeklyHeader = mainCatalog("Charts.weekly.header")
}

fileprivate extension Localizables {
    static func mainCatalog(_ key: String.LocalizationValue) -> String {
        String (localized: key, table: "Localizable")
    }
}
