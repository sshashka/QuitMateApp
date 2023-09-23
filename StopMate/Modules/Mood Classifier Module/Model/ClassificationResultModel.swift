//
//  ClassificationResultModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.04.2023.
//
import Charts

enum ClassifiedMood: String, Codable, CaseIterable, Plottable {
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
    
    var moodNumber: Int {
        switch self {
        case .angry:
            return 1
        case .disgust:
            return 0
        case .fear:
            return 2
        case .happy:
            return 5
        case .neutral:
            return 4
        case .sad:
            return 3
        case .surprise:
            return 6
        }
    }
    
    // MARK: This is a very bad code but it`s the only possible solution for charts to sort Y axis correctly
    init?(moodNumber: Int) {
        switch moodNumber {
        case 0:
            self = .disgust
        case 1:
            self = .angry
        case 2:
            self = .fear
        case 3:
            self = .sad
        case 4:
            self = .neutral
        case 5:
            self = .happy
        case 6:
            self = .surprise
        default:
            return nil
        }
    }
}

extension ClassifiedMood: Comparable {
    static func < (lhs: ClassifiedMood, rhs: ClassifiedMood) -> Bool {
        return lhs.moodNumber < rhs.moodNumber
    }
    
    static func == (lhs: ClassifiedMood, rhs: ClassifiedMood) -> Bool {
        return lhs.moodNumber == rhs.moodNumber
    }
    
    static func > (lhs: ClassifiedMood, rhs: ClassifiedMood) -> Bool {
        return lhs.moodNumber > rhs.moodNumber
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
