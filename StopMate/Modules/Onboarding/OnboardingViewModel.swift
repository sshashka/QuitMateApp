//
//  OnboardingViewModel.swift
//  StopMate
//
//  Created by Саша Василенко on 16.08.2023.
//

import Foundation

protocol OnboardingViewModelProtocol: AnyObject, ObservableObject {
    func didTapOnClose()
}

final class OnboardingViewModel: OnboardingViewModelProtocol {
    private let storageService: FirebaseStorageServiceProtocol
    var didSendEventClosure: ((OnboardingViewModel.EventTypes) -> Void)?
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func didTapOnClose() {
        storageService.updateUserOnboardingStatus()
        didSendEventClosure?(.finish)
    }
}

extension OnboardingViewModel {
    enum EventTypes {
        case finish
    }
}
