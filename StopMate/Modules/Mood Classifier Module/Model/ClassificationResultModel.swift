//
//  ClassificationResultModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.04.2023.
//

import Foundation

enum ClassifiedMood: String, Codable, CaseIterable {
    case angry = "Angry"
    case disgust = "Disgusting"
    case fear = "Fear"
    case happy = "Happy"
    case neutral = "Neutral"
    case sad = "Sad"
    case surprise = "Surprised"
    
    var classifiedMood: ClassifiedMood? {
        return ClassifiedMood(rawValue: self.rawValue)
    }
    
    func getMoodNumberValue() -> Double {
        switch self {
        case .angry:
            return 0.2
        case .disgust:
            return 0.1
        case .fear:
            return 0.3
        case .happy:
            return 0.6
        case .neutral:
            return 0.5
        case .sad:
            return 0.4
        case .surprise:
            return 0.7
        }
    }
}

//struct ClassificationResultModel {
//    let moodString: String
//    let moodConfidence: Double
//
//    var classifiedMood: ClassifiedMood? {
//        return ClassifiedMood(rawValue: moodString)
//    }
//}
