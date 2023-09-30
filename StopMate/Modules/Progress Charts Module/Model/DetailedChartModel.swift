//
//  DetailedChartModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.08.2023.
//

import Foundation

struct DetailedChartModel: Identifiable {
    let id = UUID()
    let mood: ClassifiedMood
    let count: Int
    let datesOfClassifications: [Date]
}
