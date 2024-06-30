//
//  FIrstTimeEntryViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.06.2023.
//

import Combine
import Foundation
import FirebaseAuth

protocol FirstTimeEntryViewModelProtocol: AnyObject, ObservableObject {
    var name: String { get set }
    var age: String { get set }
    var startingDate: Date { get set }
    var finishingDate: Date { get set }
    var moneySpendOnSmoking: String { get set }
    var currency: Currency { get set }
    func didTapOnFinish()
}

final class FirstTimeEntryViewModel: FirstTimeEntryViewModelProtocol, ViewModelBaseProtocol {
    let storageService: FirebaseStorageServiceProtocol
    var didSendEventClosure: ((FirstTimeEntryViewModel.EventType) -> Void)?
    @Published var name: String = ""
    @Published var age: String = ""
    @Published var startingDate: Date = Date()
    @Published var finishingDate: Date = Date()
    @Published var moneySpendOnSmoking: String = ""
    @Published var currency: Currency = .usd
    
    init (storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
    }
    
    func didTapOnFinish() {
        let id = Auth.auth().currentUser?.uid
        let email = Auth.auth().currentUser?.email
        guard let id = id else { return }
        let user = User(name: name, age: age, email: email, id: id, profileImage: nil, startingDate: startingDate, finishingDate: finishingDate, moneyUserSpendsOnSmoking: (moneySpendOnSmoking as NSString).doubleValue, userCurrency: currency)
        storageService.createNewUser(userModel: user)
        didSendEventClosure?(.end)
    }
    
//    var ageIsValid: AnyPublisher<Bool, Never> {
//        return Int(age) ?? false >= 18
//    }
}

extension FirstTimeEntryViewModel {
    enum EventType {
        case end
    }
}
