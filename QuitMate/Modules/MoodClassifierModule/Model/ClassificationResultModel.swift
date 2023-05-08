//
//  ClassificationResultModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.04.2023.
//

import Foundation

enum ClassifiedMood: String, Codable, CaseIterable {
    case angry = "Angry"
    case disgust = "Disgust"
    case fear = "Fear"
    case happy = "Happy"
    case neutral = "Neutral"
    case sad = "Sad"
    case surprise = "Surprised"
    
    var classifiedMood: ClassifiedMood? {
        return ClassifiedMood(rawValue: self.rawValue)
    }
}

struct ClassificationResultModel {
    let moodString: String
    let moodConfidence: Double
    
    var classifiedMood: ClassifiedMood? {
        return ClassifiedMood(rawValue: moodString)
    }
    
    func toDict() -> [String: Any] {
        [
            "MoodString": moodString,
            "MoodConfidence": moodConfidence
        ]
    }
}
