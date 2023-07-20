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
    @Published var isShowingError: Bool = false
    private (set) var errorText: String = ""
    @Published var userModel: User? {
        didSet {
            getViewModels()
        }
    }
    @Published var headerViewModel: HeaderViewViewModel
    
    
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
                self?.userModel = $0
            }.store(in: &disposeBag)
    }
    
    func didTapLogout() {
        // Fix
        try? Auth.auth().signOut()
    }
    
    func didTapOnAddingMood() {
        let todayDate = Date.now.toDateComponents(neededComponents: [.year, .month, .day])
        
        
        guard let latestDayOfClassification = UserDefaults.standard.object(forKey: UserDefaultsConstants.latestDayOfClassification) as? Date, latestDayOfClassification.toDateComponents(neededComponents: [.year, .month, .day]) != todayDate else {
            isShowingError.toggle()
            errorText = "Bruh"
            return
        }
        print(latestDayOfClassification)
        didSendEventClosure?(.didTapOnNewMood)
    }
    
    func getViewModels() {
        guard let user = userModel else { return }
        headerViewModel.updateWith(user: user)
    }
    
    func resetPassword() {
        authService.resetPassword()
    }
    
    func didTapOnHistory() {
        didSendEventClosure?(.didTapOnHistory)
    }
    
    func didTapOnEdit() {
        didSendEventClosure?(.didTapOnEdit)
    }
}

extension SettingsViewModel {
    enum EventType {
        case didTapOnNewMood, didTapOnHistory, didTapOnEdit
    }
}
