//
//  ReasonsToStopModuleProtocol.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.03.2023.
//

import Foundation

final class ReasonsToStopModulePresenter: ReasonsToStopPresenterProtocol {
    private let storageService: FirebaseStorageServiceProtocol
    var didSendEventClosure: ((ReasonsToStopModulePresenter.EventType) -> Void)?
    let array = ["Nicotine addiction", "Stress", "Social situations", "Habits and routines", "Weight gain", "Boredom", "Lack of support", "Alcohol consumption", "Advertising", "Low mood", "Peer pressure", "Mental health conditions", "Lack of information", "Feeling overwhelmed", "Lack of alternatives", "The belief that smoking is enjoyable", "Access to cigarettes", "Lack of commitment", "Lack of self-efficacy", "Fear of failure"]
    weak var view: ReasonsToStopViewProtocol?
    
    init(storageService: FirebaseStorageServiceProtocol, view: ReasonsToStopViewProtocol) {
        self.storageService = storageService
        self.view = view
    }
    
    func showArrayOfReasons() {
        view?.showReasons(reasons: array.sorted(by: <))
    }
    
    func didTapDoneButton(reasons: [Int]) {
        let selectedReasons = reasons.compactMap { index -> String? in
            guard index >= 0 && index < array.count else { return nil }
            return array[index]
        }
        // Remove, make it something like assosiated value
        didSendEventClosure?(.done(selectedReasons))
    }
}

extension ReasonsToStopModulePresenter {
    enum EventType {
        case done([String])
    }
}
