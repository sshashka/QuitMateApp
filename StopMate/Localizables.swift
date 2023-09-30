//
//  Localizable.swift
//  StopMate
//
//  Created by Саша Василенко on 29.09.2023.
//

import Foundation

struct Localizables {
    static let register = mainCatalog("Auth.register")
    static let email = mainCatalog("Auth.email")
    static let password = mainCatalog("Auth.password")
    static let passwordConfirm = mainCatalog("Auth.passwordConfirm")
    static let passwordEightCharacters = mainCatalog("Auth.passwordEightCharacters")
    static let forgotPassword = mainCatalog("Auth.forgotPassword")
    static let dontHaveAnAccount = mainCatalog("Auth.dontHaveAnAccount")
    static let emailWithInstructionsSent = mainCatalog("Auth.emailWithInstructionsSent")
    static let login = mainCatalog("Auth.login")
    static let alreadyHaveAnAccount = mainCatalog("Auth.alreadyHaveAnAccount")
    
    // MARK: First time entry strings
    
    static let namePromt = mainCatalog("Auth.namePrompt")
    static let name = mainCatalog("Auth.name")
    static let agePromt = mainCatalog("Auth.agePromt")
    static let age = mainCatalog("Auth.age")
    static let amountPromt = mainCatalog("Auth.amountPrompt")
    static let amount = mainCatalog("Auth.amount")
    static let startingDatePromt = mainCatalog("Auth.startingDatePromt")
    static let startingDate = mainCatalog("Auth.startingDate")
    static let finishingSmokingPromt = mainCatalog("Auth.finishingSmokingPromt")
    static let finishingDate = mainCatalog("Auth.finishingDate")
    
    static let lifeWithoutSmokingStartsNow = mainCatalog("Benefits.lifeWithoutSmoking")
    static let improvedMentalHealthHeader = mainCatalog("Benefits.improvedMentalHealthHeader")
    static let improvedMentalHealthText = mainCatalog("Benefits.improvedMentalHealthText")
    static let increasedEnergyHeader = mainCatalog("Benefits.increasedEnergyHeader")
    static let increasedEnergyText = mainCatalog("Benefits.increasedEnergyText")
    
    static let betterCirculationHeader = mainCatalog("Benefits.betterCirculationHeader")
    static let betterCirculationText = mainCatalog("Benefits.betterCirculationText")
    
    //MARK: Charts module strings
    static let chartsWeeklyHeader = mainCatalog("Charts.weekly.header")
    static let markNewMood = mainCatalog("Charts.markNewMood")
    static let detailedInfo = mainCatalog("Charts.detailedInfo")
    static let moodAlreadyMarkedToday = mainCatalog("Charts.moodAlreadyMarked")
    static let activity = mainCatalog("Charts.activity")
    static let checkMoodsPeriod = mainCatalog("Chart.checkMoods")
    
    // MARK: Main screen strings
    static let userSmokedButton = mainCatalog("MainScreen.userSmoked")
    static let quittingAnalysis = mainCatalog("MainScreen.quittingAnalysis")
    static let quittingDuration = mainCatalog("MainScreen.quittingDuration")
    static let quittingInformation = mainCatalog("MainScreen.quittingInformation")
    static let daysWithoutSmoking = mainCatalog("MainScreen.daysWithoutSmoking")
    static let moneySaved = mainCatalog("MainScreen.moneySaved")
    static let unrealeasedChemichals = mainCatalog("MainScreen.unrealeasedChemichals")
    static let daysToFinish = mainCatalog("MainScreen.DaysToFinish")
    static let progress = mainCatalog("MainScreen.progress")
    
    //MARK: Detailed charts strings
    
    static let correlationBarExplanation = mainCatalog("Charts.correlation")
    
    //MARK: Shared strings
    static let noData = mainCatalog("Shared.NoData")
}

fileprivate extension Localizables {
    static func mainCatalog(_ key: String.LocalizationValue) -> String {
        String (localized: key, table: "Localizable")
    }
}
