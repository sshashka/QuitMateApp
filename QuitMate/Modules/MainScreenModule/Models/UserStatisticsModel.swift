//
//  UserModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 29.04.2023.
//

import Foundation

struct UserStatisticsModel: Codable {
    let id: String
    let moneySpentOnSigs: Double
    let enviromentalChanges: Int
    let currnetDate = Date()
    var startingDate = Date()
    var finishingDate = Date()
    
}

extension UserStatisticsModel {
    
    var moneySpentOnSigarets: Double {
        self.moneySpentOnSigs * Double(daysWithoutSmoking)
    }
    
    var daysWithoutSmoking: Int {
        let result = substractTwoDatesInDay(from: startingDate, to: currnetDate)
        print(result)
        return result
    }
    
    private var startingToFinishingDateDifference: Int {
        substractTwoDatesInDay(from: startingDate, to: finishingDate)
    }
    
    var completionPercents: Float {
        let startingToFinishingDateDifference = startingToFinishingDateDifference
        print(startingToFinishingDateDifference)
        let daysLeft = daysWithoutSmoking
        print(daysLeft)
        let result = Float(daysLeft)/Float(startingToFinishingDateDifference)
        print(result)
        return result
    }
    
    var dateInComponentsWithoutSmoking: String {
        substractTwoDates(from: startingDate, to: currnetDate, components: [.year, .month, .day])
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
}
