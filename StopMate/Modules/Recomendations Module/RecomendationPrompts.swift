//
//  RecomendationPrompts.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.06.2023.
//

import Foundation


class RecomendationPrompts {
    
    static func getRecomendationForMoodAdded(userData: User, userStats: [UserMoodModel]) -> String {
        let userName = userData.name
        let daysWithoutSmoking = userData.daysWithoutSmoking
        let moods = userStats.map {
            $0.classification.localizedCase
        }.joined(separator: ",")
        
        return String(localized: "Recomentdations.PromptForMood.\(userName)\(daysWithoutSmoking)\(moods)")
    }
    
    static func getPromtForSmokingSession(userData: User, userStats: [UserMoodModel], reasons: [String], metrics: UserSmokingSessionMetrics) -> String {
        let userName = userData.name
        let daysWithoutSmoking = userData.daysWithoutSmoking
        let moods = userStats.map {
            $0.classification.localizedCase
        }.joined(separator: ",")
        
        let urgeToSmokeValue = metrics.urgeToSmokeValue
        let mood = metrics.classification.localizedCase
        
        
        return String(localized: "Recomentdations.PromptForSmoking.\(userName)\(daysWithoutSmoking)\(moods)\(reasons.joined(separator: ","))\(urgeToSmokeValue)\(mood)")
    }
}
