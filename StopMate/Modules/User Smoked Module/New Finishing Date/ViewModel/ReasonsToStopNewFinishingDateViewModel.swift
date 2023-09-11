//
//  ReasonsToStopNewFinishingDateViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.06.2023.
//

import Foundation


final class ReasonsToStopNewFinishingDateViewModel: ObservableObject {
    let storageService: FirebaseStorageServiceProtocol
    var didSendEventClosure: ((ReasonsToStopNewFinishingDateViewModel.EventTypes) -> Void)?
    @Published var newDate: Date = Date()
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
    }
    func updateValue() {
        storageService.updateUserFinishingDate(with: newDate)
        didSendEventClosure?(.done)
    }
    
    func doNotChangeFinishingDate() {
        didSendEventClosure?(.done)
    }
}

extension ReasonsToStopNewFinishingDateViewModel {
    enum EventTypes {
        case done
    }
}
