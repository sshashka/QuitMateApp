//
//  MontsMoodStatisticsModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.08.2023.
//

import Foundation

struct ProgressChartStatisticsModel: Identifiable {
    let id = UUID()
    let monthAndYear: Date
    let mood: ClassifiedMood
    let count: Int
}
