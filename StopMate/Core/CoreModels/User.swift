//
//  UserModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

enum Currency: String, Hashable, Codable {
    case uah = "₴"
    case usd = "$"
}

struct User: Codable {
    //MARK: - Variables
    var name: String
    var age: String
    var email: String?
    var id: String
    var profileImage: String?
    let currentDate = Date.now
    var startingDate: Date
    var finishingDate: Date
    var moneyUserSpendsOnSmoking: Double
    var userCurrency: Currency? = .usd
    var didCompleteTutorial: Bool = false
    
    //MARK: - Computed properties
    var milestoneCompleted: Bool {
        return currentDate == finishingDate || currentDate > finishingDate ? true : false
    }
    
    var moneySpentOnSigarets: Double {
        self.moneyUserSpendsOnSmoking * Double(daysWithoutSmoking)
    }
    
    var daysWithoutSmoking: Int {
        let result = substractTwoDatesInDay(from: startingDate, to: currentDate)
        return result
    }
    
    var completionPercents: Double {
        let startingToFinishingDateDifference = startingToFinishingDateDifference
        let daysLeft = daysWithoutSmoking
        let result = Double(daysLeft)/Double(startingToFinishingDateDifference)
        return result
    }
    
    var daysToFinish: Int {
        substractTwoDatesInDay(from: currentDate, to: milestoneCompleted ? currentDate : finishingDate)
    }
    
    var dateInComponentsWithoutSmoking: String {
        substractTwoDates(from: startingDate, to: currentDate, components: [.year, .month, .day])
    }
    //MARK: - Public methods
    func substractTwoDatesInDay(from lessDate: Date, to moreDate: Date) -> Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: lessDate, to: moreDate).day!
    }
    
    func substractTwoDates(from lessDate: Date, to moreDate: Date, components: Set<Calendar.Component>) -> String {
        let calendar = Calendar.current
        let difference = calendar.dateComponents(components, from: lessDate, to: moreDate)
        return difference.toSting()
    }
    
    // Unfortunately Firebase Realtime does not support Codable for update operations
    func toDictionary() -> [AnyHashable: Any] {
        var dict: [AnyHashable: Any] = [
            "name": name,
            "age": age,
            "id": id,
            "startingDate": startingDate.timeIntervalSinceReferenceDate,
            "finishingDate": finishingDate.timeIntervalSinceReferenceDate,
            "moneyUserSpendsOnSmoking": moneyUserSpendsOnSmoking
        ]
        
        if let email = email {
            dict["email"] = email
        }
        
        if let profileImage = profileImage {
            dict["profileImage"] = profileImage
        }
        
        return dict
    }
}
//MARK: - Private methods
extension User {
    private var startingToFinishingDateDifference: Int {
        substractTwoDatesInDay(from: startingDate, to: milestoneCompleted ? currentDate : finishingDate)
    }
}
