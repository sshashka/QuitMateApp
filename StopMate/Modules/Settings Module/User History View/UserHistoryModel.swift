//
//  UserHistoryModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.07.2023.
//

import Foundation

enum UserHistoryRecordsType: String, Codable {
    case moodRecords = "Mood record", timerResetsRecords = "Timer record"
    
    var selectedType: UserHistoryRecordsType? {
        return UserHistoryRecordsType(rawValue: self.rawValue)
    }
}

struct UserHistoryModel: Codable, Hashable {
    let id = UUID()
    var dateOfClassification: Date
    var selectedMoood: ClassifiedMood?
    var selectedReasons: [ReasonsToStop]?
    var recomendation: String
    var typeOfHistory: UserHistoryRecordsType
    
    var dateOfClassificationFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d/MMM/yyyy"
        return dateFormatter.string(from: dateOfClassification)
    }
}
