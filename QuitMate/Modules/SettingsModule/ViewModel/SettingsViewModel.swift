//
//  SettingsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.05.2023.
//

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    var didSendEventClosure: ((SettingsViewModel.EventType) -> Void)?
    private let storageService: FirebaseStorageServiceProtocol
    private var disposeBag = Set<AnyCancellable>()
    @Published var userModel: User? {
        didSet {
            getViewModels()
        }
    }
    @Published var headerViewModel: HeaderViewViewModel
    
    func didTapLogout() {
        
    }
    
    func didTapOnAddingMood() {
        didSendEventClosure?(.didTapOnNewMood)
    }
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        let user = User(name: "", age: "", id: "", moneyUserSpendsOnSmoking: 0.0)
        self.headerViewModel = HeaderViewViewModel(user: user)
        getUserModel()
    }
    
    func getUserModel() {
        // Fix to storage service
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
        AuthentificationService().resetPassword()
    }
}

extension SettingsViewModel {
    enum EventType {
        case didTapOnNewMood
    }
}
