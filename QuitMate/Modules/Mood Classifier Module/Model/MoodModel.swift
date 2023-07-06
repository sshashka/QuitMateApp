//
//  MoodModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 27.04.2023.
//

import Foundation

struct MoodModel: Codable {
//    let dateOfClassification = Date.now
    let id: String
    let classification: ClassifiedMood
    var totalScore: Int {
        switch classification {
        case .angry:
            return 1
        case .disgust:
            return 2
        case .fear:
            return 3
        case .happy:
            return 4
        case .neutral:
            return 5
        case .sad:
            return 6
        case .surprise:
            return 7
        }
    }
}
