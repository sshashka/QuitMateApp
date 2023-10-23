//
//  ReasonsToStopModuleProtocol.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.03.2023.
//

import Foundation

enum ReasonsToStop: String, Codable, CaseIterable {
    case nicotineAddiction = "Nicotine addiction"
    case stress = "Stress"
    case socialSituations = "Social situations"
    case habits = "Habits and routines"
    case weightGain = "Weight gain"
    case boredom = "Boredom"
    case lackOfSupport = "Lack of support"
    case alcoholConsumption = "Alcohol consumption"
    case advertising = "Advertising"
    case lowMood = "Low mood"
    case peerPressure = "Peer pressure"
    case mentalHealthConditions = "Mental health conditions"
    case lackOfInformation = "Lack of information"
    case feelingOverwhelmed = "Feeling overwhelmed"
    case lackOfAlternatives = "Lack of alternatives"
    case beliefThatSmokingIsEnjoyable = "The belief that smoking is enjoyable"
    case accessToCigarettes = "Access to cigarettes"
    case lackOfCommitment = "Lack of commitment"
    case lackOfSelfEfficacy = "Lack of self-efficacy"
    case fearOfFailure = "Fear of failure"
    
    var localizedCase: String {
        switch self {
        case .nicotineAddiction: return Localizables.ReasonsToStopStrings.nicotineAddiction
        case .stress: return Localizables.ReasonsToStopStrings.stress
        case .socialSituations: return Localizables.ReasonsToStopStrings.socialSituations
        case .habits: return Localizables.ReasonsToStopStrings.habits
        case .weightGain: return Localizables.ReasonsToStopStrings.weitghtGain
        case .boredom: return Localizables.ReasonsToStopStrings.boredom
        case .lackOfSupport: return Localizables.ReasonsToStopStrings.lackOfSupport
        case .alcoholConsumption: return Localizables.ReasonsToStopStrings.alcoholConsumption
        case .advertising: return Localizables.ReasonsToStopStrings.advertising
        case .lowMood: return Localizables.ReasonsToStopStrings.lowMood
        case .peerPressure: return Localizables.ReasonsToStopStrings.peerPressure
        case .mentalHealthConditions: return Localizables.ReasonsToStopStrings.mentalHealthConditions
        case .lackOfInformation: return Localizables.ReasonsToStopStrings.lackOfInformation
        case .feelingOverwhelmed: return Localizables.ReasonsToStopStrings.feelingOverwhelmed
        case .lackOfAlternatives: return Localizables.ReasonsToStopStrings.lackOfAlternatives
        case .beliefThatSmokingIsEnjoyable: return Localizables.ReasonsToStopStrings.beliefThatSmokingIsEnjoyable
        case .accessToCigarettes: return Localizables.ReasonsToStopStrings.accessToCigarettes
        case .lackOfCommitment: return Localizables.ReasonsToStopStrings.lackOfCommitment
        case .lackOfSelfEfficacy: return Localizables.ReasonsToStopStrings.lackOfSelfEfficacy
        case .fearOfFailure: return Localizables.ReasonsToStopStrings.fearOfFailure
        }
    }
    
}

final class ReasonsToStopModulePresenter: ReasonsToStopPresenterProtocol {
    private weak var view: ReasonsToStopViewProtocol?
    private let storageService: FirebaseStorageServiceProtocol
    var didSendEventClosure: ((ReasonsToStopModulePresenter.EventType) -> Void)?
    let array = ReasonsToStop.allCases
    
    init(storageService: FirebaseStorageServiceProtocol, view: ReasonsToStopViewProtocol) {
        self.storageService = storageService
        self.view = view
    }
    
    func showArrayOfReasons() {
        view?.showReasons(reasons: array)
    }
    
    func didTapDoneButton(reasons: [Int]) {
        let selectedReasons = reasons.compactMap { index -> ReasonsToStop? in
            guard index >= 0 && index < array.count else { return nil }
            return array[index]
        }
        didSendEventClosure?(.done(selectedReasons))
    }
}

extension ReasonsToStopModulePresenter {
    enum EventType {
        case done([ReasonsToStop])
    }
}
