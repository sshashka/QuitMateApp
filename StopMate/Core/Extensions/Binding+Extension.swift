//
//  Binding+Extension.swift
//  QuitMate
//
//  Created by Саша Василенко on 03.05.2023.
//

import SwiftUI

extension Binding where Value == Int {
    var value: Double {
        Double(wrappedValue)
    }
}

