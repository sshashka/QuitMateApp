//
//  AdditionalInfoViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import Foundation

protocol AddAdditionalInfoViewModelProtocol: ObservableObject {
    var dailyData: String { get }
    var weeklyData: String { get }
    var monthlyData: String { get }
    var yearlyData: String { get }
    var headerText: String { get }
    var explanatoryText: String { get }
}

class AdditionalInfoViewModel: AddAdditionalInfoViewModelProtocol, ObservableObject {
    private let value: AdditionalInfoModel
    var headerText: String
    var explanatoryText: String
    
    private (set) var dailyData: String = ""
    private (set) var weeklyData: String = ""
    private (set) var monthlyData: String = ""
    private (set) var yearlyData: String = ""
    
    
    init(value: AdditionalInfoModel, headerText: String, explanatoryText: String) {
        self.value = value
        self.headerText = headerText
        self.explanatoryText = explanatoryText
        getData()
    }
    
    func getData() {
        let allData = value.getValueSet()
        dailyData = allData.dailyValue
        weeklyData = allData.weeklyValue
        monthlyData = allData.monthlyValue
        yearlyData = allData.yearlyValue
    }
}
