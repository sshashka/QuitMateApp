//
//  AdditionalInfoViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import Foundation

class AdditionalInfoViewModel: ObservableObject {
    let model: [AdditionalInfoModel]
    
    init(model: [AdditionalInfoModel]) {
        self.model = model
    }
}
