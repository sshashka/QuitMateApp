//
//  UserModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.05.2023.
//

import Foundation

struct User: Codable {
    var name: String
    var age: String
    var email: String?
    var id: String
    var profileImage: String?
    let currentDate = Date.now
    var startingDate: Date
    var finishingDate: Date
    var moneyUserSpendsOnSmoking: Double
        // Add currency support in future
//    var userCurrency: Currency
    func profileImageInData() -> Data? {
        guard let profileImage else { return nil }
        return Data(base64Encoded: profileImage)
    }
}

extension User {
    
    var moneySpentOnSigarets: Double {
        self.moneyUserSpendsOnSmoking * Double(daysWithoutSmoking)
    }
    
    var daysWithoutSmoking: Int {
        let result = substractTwoDatesInDay(from: startingDate, to: currentDate)
        return result
    }
    
    private var startingToFinishingDateDifference: Int {
        substractTwoDatesInDay(from: startingDate, to: finishingDate)
    }
    
    var completionPercents: Float {
        let startingToFinishingDateDifference = startingToFinishingDateDifference
        let daysLeft = daysWithoutSmoking
        let result = Float(daysLeft)/Float(startingToFinishingDateDifference)
        return result
    }
    
    var dateInComponentsWithoutSmoking: String {
        substractTwoDates(from: startingDate, to: currentDate, components: [.year, .month, .day])
    }
    
    func substractTwoDatesInDay(from lessDate: Date, to moreDate: Date) -> Int {
        let calendar = Calendar.current
        return calendar.dateComponents([.day], from: lessDate, to: moreDate).day!
    }
    
    func substractTwoDates(from lessDate: Date, to moreDate: Date, components: Set<Calendar.Component>) -> String {
        let calendar = Calendar.current
        let difference = calendar.dateComponents(components, from: lessDate, to: moreDate)
        return difference.toSting()
    }
    
    var daysToFinish: Int {
        substractTwoDatesInDay(from: currentDate, to: finishingDate)
    }
    
    private var weeksWithoutSmoking: Int {
        daysWithoutSmoking / 7
    }
    
    private var monthsWithoutSmoking: Int {
        daysWithoutSmoking / 30
    }
    
    private var yearsWithoutSmoking: Int {
        daysWithoutSmoking / 365
    }
    
    private var moneySavedPerWeek: Double {
        moneySpentOnSigarets * 7
    }
    
    private var moneySavedPerMonth: Double {
        moneySpentOnSigarets * 30
    }
    
    private var moneySavedPerYear: Double {
        moneySpentOnSigarets * 365
    }
}

//extension User {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        age = try container.decode(String.self, forKey: .age)
//        email = try container.decodeIfPresent(String.self, forKey: .email) ??
//        id = try container.decode(String.self, forKey: .id)
//        profileImage = try? container.decode(Data.self, forKey: .profileImage)
//        
//        startingDate = try container.decode(Date.self, forKey: .startingDate)
//        finishingDate = try container.decode(Date.self, forKey: .finishingDate)
//        moneyUserSpendsOnSmoking = try container.decode(Double.self, forKey: .moneyUserSpendsOnSmoking)
//    }
//}
