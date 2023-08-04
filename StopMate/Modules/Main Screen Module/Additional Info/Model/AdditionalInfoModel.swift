//
//  AdditionalInfoModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import Foundation

struct AdditionalInfoModel: Hashable {
    let id = UUID()
    let icon: String
    let text: String
    let value: String
    let bottomText: String
}
