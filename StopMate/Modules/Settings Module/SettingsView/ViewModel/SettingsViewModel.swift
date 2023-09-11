//
//  SettingsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.05.2023.
//

import Foundation
import Combine
import FirebaseAuth

protocol SettingsViewModelProtocol: AnyObject {
    var isShowingAlert: Bool { get set }
    var errorText: String { get }
    var userModel: User? { get }
    // TODO: replace HeaderViewViewModel with HeaderViewViewModelProtocol
    var headerViewModel: HeaderViewViewModel { get }
    var isShowingAlertPublisher: Published<Bool>.Publisher { get }
    func didTapOnOnboarding()
    func didTapLogout()
    func didTapOnAddingMood()
    func updateUserProfilePic()
    func resetPassword()
    func didTapOnHistory()
    func didTapOnEdit()
    func didTapOnAccountDelete()
}

final class SettingsViewModel: ObservableObject, SettingsViewModelProtocol {
    @Published var isShowingAlert: Bool = false
    var isShowingAlertPublisher: Published<Bool>.Publisher { $isShowingAlert }
    
    private var disposeBag = Set<AnyCancellable>()

    private let storageService: FirebaseStorageServiceProtocol
    private let authService: AuthentificationServiceProtocol
    
    private (set) var errorText: String = ""
    @Published private var userMoods: [UserMoodModel] = [UserMoodModel]()
    
    var didSendEventClosure: ((SettingsViewModel.EventType) -> Void)?
    
    
    @Published var userModel: User? {
        didSet {
            getViewModels()
        }
    }
    
    @Published private var userProfilePic: Data? {
        didSet {
            updateUserProfilePic()
        }
    }
    
    @Published var headerViewModel: HeaderViewViewModel
    
    init(storageService: FirebaseStorageServiceProtocol, authService: AuthentificationServiceProtocol) {
        self.storageService = storageService
        self.authService = authService
        let user = User(name: "", age: "", id: "", startingDate: Date(), finishingDate: Date(), moneyUserSpendsOnSmoking: 0.0)
        self.headerViewModel = HeaderViewViewModel(user: user)
        getUserModel()
        getUserProfilePic()
        getUserMoods()
        
    }
    
    private func getUserModel() {
//        storageService.userPublisher
        storageService.userDataPublisher
            .sink {
                print($0)
            } receiveValue: {[weak self] in
                self?.userModel = $0
            }.store(in: &disposeBag)
    }
    
    private func getUserMoods() {
        storageService.getUserMoodsData().sink { _ in
            print()
        } receiveValue: { [weak self] data in
            self?.userMoods = data
        }.store(in: &disposeBag)

    }
    
    private func getUserProfilePic() {
        storageService.userProfilePicturePublisher.sink { completion in
            print("\(#function) \(completion)")
        } receiveValue: { [weak self] data in
            self?.userProfilePic = data
        }.store(in: &disposeBag)
    }
    
    func didTapOnOnboarding() {
        didSendEventClosure?(.didTapOnOnboarding)
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
        headerViewModel.updateWith(user: user)
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
    
    func didTapOnAccountDelete() {
        authService.deleteAccount()
    }
    
    private var canAddNewMood: Bool {
        let dates = userMoods.map {
            $0.dateOfClassification
        }
        return Date.checkIfArrayContainsToday(array: dates)
    }
}

extension SettingsViewModel {
    enum EventType {
        case didTapOnNewMood, didTapOnHistory, didTapOnEdit, didTapOnOnboarding
    }
}
