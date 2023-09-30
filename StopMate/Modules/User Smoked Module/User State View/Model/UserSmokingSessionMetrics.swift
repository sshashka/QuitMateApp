//
//  UserStateModel.swift
//  StopMate
//
//  Created by Саша Василенко on 30.08.2023.
//

import Foundation

/// Model that represents user
/// emotional state when user clicked on 'I smoked' button
/// - Parameters
///   - urgeToSmokeValue: parameter that represents how much user wanted to smoke on a scale from 1 to 10
///   - selectedMood: parameter that represents mood of the user when he smoked
///   - dateOfClassification: parameter that represents date of entry
struct UserSmokingSessionMetrics: Codable, Identifiable, ChartDataFilteringProtocol {
    let id: UUID = UUID()
    let urgeToSmokeValue: Int
    let classification: ClassifiedMood
    var dateOfClassification = Date()
    
    var dateOfClassificationMonthAndYear: Date {
        let components = dateOfClassification.toDateComponents(neededComponents: [.day, .month, .year])
        let date = NSCalendar.current.date(from: components)
        return date ?? Date()
    }
}



