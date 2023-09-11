//
//  ChartModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 29.04.2023.
//

import Foundation

struct UserMoodModel: Codable, Identifiable, Hashable, ChartDataFilteringProtocol {
    let id: String
    var dateOfClassification = Date()
    let classification: ClassifiedMood
    var classificationString: String {
        self.classification.rawValue
    }
    
    var dateOfClassificationMonthAndYear: Date {
        let components = dateOfClassification.toDateComponents(neededComponents: [.month, .year])
        let date = NSCalendar.current.date(from: components)
        return date ?? Date()
    }
}
