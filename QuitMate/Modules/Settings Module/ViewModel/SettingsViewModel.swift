//
//  SettingsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.05.2023.
//

import Foundation
import Combine
import FirebaseAuth

final class SettingsViewModel: ObservableObject {
    private let storageService: FirebaseStorageServiceProtocol
    private let authService: AuthentificationServiceProtocol
    var didSendEventClosure: ((SettingsViewModel.EventType) -> Void)?
    private var disposeBag = Set<AnyCancellable>()
    @Published var userModel: User? {
        didSet {
            getViewModels()
        }
    }
    @Published var headerViewModel: HeaderViewViewModel
    
    func didTapLogout() {
        try? Auth.auth().signOut()
    }
    
    func didTapOnAddingMood() {
        didSendEventClosure?(.didTapOnNewMood)
    }
    
    init(storageService: FirebaseStorageServiceProtocol, authService: AuthentificationServiceProtocol) {
        self.storageService = storageService
        self.authService = authService
        let user = User(name: "", age: "", id: "", startingDate: Date(), finishingDate: Date(), moneyUserSpendsOnSmoking: 0.0)
        self.headerViewModel = HeaderViewViewModel(user: user)
        getUserModel()
    }
    
    func getUserModel() {
        storageService.getUserModel()
            .sink {
                print($0)
            } receiveValue: {[weak self] in
                self?.userModel = $0.last
            }.store(in: &disposeBag)
    }
    
    func getViewModels() {
        guard let user = userModel else { return }
        headerViewModel.updateWith(user: user)
    }
    
    func resetPassword() {
        authService.resetPassword()
    }
}

extension SettingsViewModel {
    enum EventType {
        case didTapOnNewMood
    }
}
