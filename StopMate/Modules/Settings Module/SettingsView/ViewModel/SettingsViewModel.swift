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
    @Published var isShowingAlert: Bool = false
    private (set) var errorText: String = ""
    @Published private var userMoods: [ChartModel] = [ChartModel]()
    @Published var userModel: User? {
        didSet {
            getViewModels()
        }
    }
    
    @Published var userProfilePic: Data? {
        didSet {
            guard let userModel else { return }
            updateUserProfilePic()
        }
    }
    
    
    
    @Published var headerViewModel: HeaderViewViewModel
    init(storageService: FirebaseStorageServiceProtocol, authService: AuthentificationServiceProtocol) {
        self.storageService = storageService
        self.authService = authService
        let user = User(name: "", age: "", id: "", startingDate: Date(), finishingDate: Date(), moneyUserSpendsOnSmoking: 0.0)
        self.headerViewModel = HeaderViewViewModel(user: user, userPic: nil)
        getUserModel()
        getUserProfilePic()
        getUserMoods()
    }
    
    func getUserModel() {
//        storageService.userPublisher
        storageService.userDataPublisher
            .sink {
                print($0)
            } receiveValue: {[weak self] in
                self?.userModel = $0
            }.store(in: &disposeBag)
    }
    
    func getUserMoods() {
        storageService.getChartsData().sink { _ in
            print()
        } receiveValue: { [weak self] data in
            self?.userMoods = data
        }.store(in: &disposeBag)

    }
    
    func getUserProfilePic() {
        storageService.userProfilePicturePublisher.sink { completion in
            print("\(#function) \(completion)")
        } receiveValue: { [weak self] data in
            self?.userProfilePic = data
        }.store(in: &disposeBag)
    }
    
    func didTapLogout() {
        // Fix
        try? Auth.auth().signOut()
    }
    
    func didTapOnAddingMood() {
        guard canAddNewMood else {
            errorText = "You have already marked your mood today. So, come back tomorrow."
            isShowingAlert.toggle()
            return
        }
        didSendEventClosure?(.didTapOnNewMood)
    }
    
    func getViewModels() {
        guard let user = userModel else { return }
        headerViewModel.updateWith(user: user, userPic: nil)
    }
    
    func updateUserProfilePic() {
        headerViewModel.updatePhoto(image: userProfilePic)
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
    
    private var canAddNewMood: Bool {
        let dates = userMoods.map {
            $0.dateOfClassificationByDate
        }
        let currentDate = Date.now
        let containsToday = dates.contains { date in
            Calendar.current.isDate(date, inSameDayAs: currentDate)
        }
        return !containsToday
    }
}

extension SettingsViewModel {
    enum EventType {
        case didTapOnNewMood, didTapOnHistory, didTapOnEdit
    }
}
