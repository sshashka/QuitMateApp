//
//  ChartModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 29.04.2023.
//

import Foundation

struct ChartModel: Codable, Identifiable {
    let id: String
    var dateOfClassification = Date()
    let classification: ClassifiedMood
    var classificationString: String {
        self.classification.rawValue
    }
//    var animate = false
    var dateOfClassificationByDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let components = dateOfClassification.toDateComponents(neededComponents: [.year, .month, .day])
        let date = NSCalendar.current.date(from: components)
        return date ?? Date()
    }
    
    var dateOfClassificationMonthAndYear: Date {
        let components = dateOfClassification.toDateComponents(neededComponents: [.month, .year])
        let date = NSCalendar.current.date(from: components)
        return date ?? Date()
    }
    
    var scoreForUser: Int {
        switch classification {
        case .angry:
            return 11
        case .disgust:
            return 12
        case .fear:
            return 10
        case .happy:
            return 20
        case .neutral:
            return 18
        case .sad:
            return 16
        case .surprise:
            return 22
        }
    }
}
