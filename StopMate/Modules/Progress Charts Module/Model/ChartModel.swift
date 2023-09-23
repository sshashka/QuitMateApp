//
//  ChartModel.swift
//  StopMate
//
//  Created by Саша Василенко on 04.09.2023.
//

import Foundation
import Charts


struct ChartModel: Identifiable, Equatable {
    let id: UUID
    enum ChartModelTypes: String, Plottable {
        case smoking = "Smoking sessions"
        case moods = "Marked moods"
    }
    let type: ChartModelTypes
    let mood: ClassifiedMood
    let date: Date
}

extension ChartModel: Comparable {
    static func < (lhs: ChartModel, rhs: ChartModel) -> Bool {
        return lhs.mood < rhs.mood
    }
    
    static func == (lhs: ChartModel, rhs: ChartModel) -> Bool {
        return lhs.mood == rhs.mood
    }
    
    static func > (lhs: ChartModel, rhs: ChartModel) -> Bool {
        return lhs.mood > rhs.mood
    }
}
