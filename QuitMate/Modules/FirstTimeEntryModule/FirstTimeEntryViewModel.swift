//
//  FIrstTimeEntryViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.06.2023.
//

import Combine
import Foundation
import FirebaseAuth

final class FirstTimeEntryViewModel: ObservableObject {
    let storageService: FirebaseStorageServiceProtocol
    var didSendEventClosure: ((FirstTimeEntryViewModel.EventType) -> Void)?
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var startingDate: Date = Date()
    @Published var finishingDate: Date = Date()
    @Published var moneySpendOnSmoking: String = ""
    
    init (authService: FirebaseStorageServiceProtocol) {
        self.storageService = authService
    }
    
    func didTapOnFinish() {
        let id = Auth.auth().currentUser?.uid
        guard let id = id else { return }
        let user = User(name: name, age: age, email: nil, id: id, profileImage: nil, startingDate: startingDate, finishingDate: finishingDate, moneyUserSpendsOnSmoking: (moneySpendOnSmoking as NSString).doubleValue)
        storageService.createNewUser(userModel: user)
        didSendEventClosure?(.end)
    }
}

extension FirstTimeEntryViewModel {
    enum EventType {
        case end
    }
}
