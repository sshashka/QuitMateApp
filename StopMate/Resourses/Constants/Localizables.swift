//
//  Localizable.swift
//  StopMate
//
//  Created by Саша Василенко on 29.09.2023.
//

import Foundation

struct Localizables {
    struct AuthStrings {
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
    }
    
    
    // MARK: First time entry strings
    struct FirstTimeEntryStrings {
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
        static let privacyPolicy = mainCatalog("Benefits.PrivacyPolicy")
    }
    
    //MARK: Charts module strings
    struct ChartsStrings {
        static let chartsWeeklyHeader = mainCatalog("Charts.weekly.header")
        static let markNewMood = mainCatalog("Charts.markNewMood")
        static let detailedInfo = mainCatalog("Charts.detailedInfo")
        static let moodAlreadyMarkedToday = mainCatalog("Charts.moodAlreadyMarked")
        static let activity = mainCatalog("Charts.activity")
        static let checkMoodsPeriod = mainCatalog("Chart.checkMoods")
        
        
    }
    
    // MARK: Main screen strings
    struct MainScreen {
        static let userSmokedButton = mainCatalog("MainScreen.userSmoked")
        static let quittingAnalysis = mainCatalog("MainScreen.quittingAnalysis")
        static let quittingDuration = mainCatalog("MainScreen.quittingDuration")
        static let quittingInformation = mainCatalog("MainScreen.quittingInformation")
        static let daysWithoutSmoking = mainCatalog("MainScreen.daysWithoutSmoking")
        static let moneySaved = mainCatalog("MainScreen.moneySaved")
        static let unrealeasedChemichals = mainCatalog("MainScreen.unrealeasedChemichals")
        static let daysToFinish = mainCatalog("MainScreen.DaysToFinish")
        static let progress = mainCatalog("MainScreen.progress")
        static let additionalScreenSavingsHeader = mainCatalog("AdditionalScreen.savingsHeader")
        static let additionalScreenSavingsExplanatory = mainCatalog("AdditionalScreen.savingsExplanatory")
        static let additionalScreenPollutions = mainCatalog("AdditionalScreen.pollutionsHeader")
        static let additionalScreenPollutionsExplanatory = mainCatalog("AdditionalScreen.pollutionsExplanatory")
    }
    
    //MARK: Detailed charts strings
    struct DetailedCharts {
        static let correlationBarExplanation = mainCatalog("Charts.correlation")
        static let chartAboveMoodsDetails = mainCatalog("Charts.chartAboveMoodsDetails")
        static let moodsCount = mainCatalog("Charts.moodsCount.%lld%lld")
        
        
        static let monthlyChartExplanation = mainCatalog("Charts.monthlyChartExplanation")
    }
    
    
    //MARK: Shared strings
    static let noData = mainCatalog("Shared.NoData")
    static let day = mainCatalog("Shared.day")
    static let week = mainCatalog("Shared.week")
    static let month = mainCatalog("Shared.month")
    static let year = mainCatalog("Shared.year")
    static let info = mainCatalog("Shared.Info")
    
    struct Shared {
        static let name = mainCatalog("Shared.name")
        static let age = mainCatalog("Shared.age")
        static let done = mainCatalog("Shared.done")
        static let finish = mainCatalog("Shared.finish")
        static let next = mainCatalog("Shared.next")
        static let smokingSeesions = mainCatalog("Shared.smokingSessions")
        static let markedMoods = mainCatalog("Shared.markedMoods")
        
        static let twoWeeks = mainCatalog("Shared.twoWeeks")
        static let month = mainCatalog("Shared.month.%lld")
        static let sure = mainCatalog("Shared.sure")
        static let cancel = mainCatalog("Shared.cancel")
        static let ok = mainCatalog("Shared.ok")
        static let yes = mainCatalog("Shared.yes")
        static let no = mainCatalog("Shared.no")
    }
    
    //MARK: Onboarding view strings
    struct OnboardingStrings {
        static let smokingSessionHeader = mainCatalog("Onboarding.smokingHeader")
        static let smokingSessionDescription = mainCatalog("Onboarding.smokingDescription")
        static let viewMoodsHeader = mainCatalog("Onboarding.viewMoodsHeader")
        static let viewMoodsDescription = mainCatalog("Onboarding.viewMoodsDescription")
        static let onboardingDetailedInfoHeader = mainCatalog("Onboarding.onboardingDetailedInfoHeader")
        static let onboardingDetailedInfoDescription = mainCatalog("Onboarding.onboardingDetailedInfoDescription")
        static let markingNewMoodHeader = mainCatalog("Onboarding.markingNewMoodHeader")
        static let markingNewMoodDescription = mainCatalog("Onboarding.markingNewMoodDescription")
        static let changingSettingsHeader = mainCatalog("Onboarding.changingSettingsHeader")
        static let changingSettingsDescription = mainCatalog("Onboarding.changingSettingsDescription")
        static let onboardingHeader = mainCatalog("Onboarding.onboardingHeader")
        static let onboardingDescription = mainCatalog("Onboarding.Description")
    }
    
    //MARK: Videos view strings
    struct VideosStrings {
        static let videos = mainCatalog("Videos.videos")
        static let startWatching = mainCatalog("Videos.startWatching")
    }
    
    //MARK: User smoked module strings
    
    struct UserSmokedModuleStrings {
        static let tellUsAboutEmotionalState = mainCatalog("UserSmoked.tellUsAboutEmotionalState")
        static let urgeToSmokePromt = mainCatalog("UserSmoked.urgeToSmokePromt")
        static let howDidYouFeel = mainCatalog("UserSmoked.howDidYouFeelPromt")
        static let selectUpTenReasons = mainCatalog("UserSmoked.selectUp10Reasons")
        
        static let setNewFinishingDate = mainCatalog("UserSmoked.setNewFinishingDate")
        static let dontChangeFinishingDate = mainCatalog("UserSmoked.dontChangeFinishingDate")
    }
    
    //MARK: Settings module strings
    struct SettingsStrings {
        static let changePassword = mainCatalog("Settings.changePassword")
        static let termsAndConditions = mainCatalog("Settings.termsAndConditions")
        static let privacyPolicy = mainCatalog("Settings.privacyPolicy")
        static let watchYourHistory = mainCatalog("Settings.WatchHistory")
        static let deleteAccuont = mainCatalog("Settings.deleteAccount")
        
        static let accountDeleteTitile = mainCatalog("Settings.accountDeleteTitle")
        static let accountDeleteMessage = mainCatalog("Settings.accountDeleteMessage")
        
        static let passwordResetAlertTitle = mainCatalog("Settings.passwordResetAlertTitle")
        static let passwordResetAlertMessage = mainCatalog("Settings.passwordResetAlertMessage")
        static let resetPasswordPromt = mainCatalog("Settings.resetPasswordPromt")
        static let logout = mainCatalog("Settings.logout")
        static let edit = mainCatalog("Settings.edit")
    }
    
    struct MoodsStrings {
        static let angry = mainCatalog("Moods.angry")
        static let disgust = mainCatalog("Moods.disgust")
        static let fear = mainCatalog("Moods.fear")
        static let happy = mainCatalog("Moods.happy")
        static let neutral = mainCatalog("Moods.neutral")
        static let sad = mainCatalog("Moods.sad")
        static let surprise = mainCatalog("Moods.surprise")
    }
    
    struct EditProfileStrings {
        static let setNewPhoto = mainCatalog("EditProfile.setNewPhoto")
        static let personalInformation = mainCatalog("EditProfile.personalInformation")
        static let contactInfo = mainCatalog("EditProfile.contactInfo")
    }
    
    struct MoodModuleStrings {
        static let hey = mainCatalog("MoodModuleStrings.hey")
        static let whatIsInYourMind = mainCatalog("MoodModuleStrings.whatIsInYourMind")
        static let iFeel = mainCatalog("MoodModuleStrings.iFeel")
    }
    
    struct UserHistoryStrings {
        static let navigationTitle = mainCatalog("UserHistory.navigationTitle")
        static let moods = mainCatalog("UserHistory.moods")
        static let smokingSessions = mainCatalog("UserHistory.smokingSessions")
        static let selectTypeOfHistory = mainCatalog("UserHistory.selectTypeOfHistory")
    }
    
    struct ReasonsToStopStrings {
        static let nicotineAddiction = mainCatalog("ReasonsToStop.nicotineAddiction")
        static let stress = mainCatalog("ReasonsToStop.stress")
        static let socialSituations = mainCatalog("ReasonsToStop.socialSituations")
        static let habits = mainCatalog("ReasonsToStop.HabitsAndRoutines")
        static let weitghtGain = mainCatalog("ReasonsToStop.weightGain")
        static let boredom = mainCatalog("ReasonsToStop.boredom")
        static let lackOfSupport = mainCatalog("ReasonsToStop.lackOfSupport")
        static let alcoholConsumption = mainCatalog("ReasonsToStop.alcoholConsumption")
        static let advertising = mainCatalog("ReasonsToStop.advertising")
        static let lowMood = mainCatalog("ReasonsToStop.lowMood")
        static let peerPressure = mainCatalog("ReasonsToStop.peerPressure")
        static let mentalHealthConditions = mainCatalog("ReasonsToStop.mentalHealthConditions")
        static let lackOfInformation = mainCatalog("ReasonsToStop.lackOfInformation")
        static let feelingOverwhelmed = mainCatalog("ReasonsToStop.feelingOverwhelmed")
        static let lackOfAlternatives = mainCatalog("ReasonsToStop.lackOfAlternatives")
        static let beliefThatSmokingIsEnjoyable = mainCatalog("ReasonsToStop.beliefThatSmokingIsEnjoyable")
        static let accessToCigarettes = mainCatalog("ReasonsToStop.accessToCigarettes")
        static let lackOfCommitment = mainCatalog("ReasonsToStop.lackOfCommitment")
        static let lackOfSelfEfficacy = mainCatalog("ReasonsToStop.lackOfSelfEfficacy")
        static let fearOfFailure = mainCatalog("ReasonsToStop.fearOfFailure")
    }
    
    struct MilestoneCompletedStrings {
        static let header = mainCatalog("MilestoneCompletedStrings.header")
        static let bottomText = mainCatalog("MilestoneCompletedStrings.bottomText")
        static let continueUsingAsDiary = mainCatalog("MilestoneCompletedStrings.continueUsingAsDiary")
        static let setANewDate = mainCatalog("MilestoneCompletedStrings.setANewDate")
    }
    
}

fileprivate extension Localizables {
    static func mainCatalog(_ key: String.LocalizationValue) -> String {
        String(localized: key, table: "Localizable")
    }
}
