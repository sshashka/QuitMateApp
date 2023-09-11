//
//  UserEmotionalStateViewModel.swift
//  StopMate
//
//  Created by Саша Василенко on 30.08.2023.
//

import Combine

protocol UserEmotionalStateViewModelProtocol: AnyObject, ObservableObject {
    var urgeToSmokeValue: Int? { get set }
    var selectedMood: ClassifiedMood? { get set }
    var isDoneButtonEnabled: Bool { get }
    func didTapOnDoneButton()
    func didTapOnCloseButton()
}

final class UserEmotionalStateViewModel: UserEmotionalStateViewModelProtocol {
    var didSendEventClosure: ((UserEmotionalStateViewModel.EventTypes) -> Void)?
    
    private let storageService: FirebaseStorageServiceProtocol
    
    @Published var urgeToSmokeValue: Int?
    
    @Published var selectedMood: ClassifiedMood?
    
    @Published var isDoneButtonEnabled: Bool = false
    
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        userSelectedAllFields.assign(to: &$isDoneButtonEnabled)
    }
    
    func didTapOnDoneButton() {
        guard let urgeToSmokeValue, let selectedMood else { return }
        let model = UserSmokingSessionMetrics(urgeToSmokeValue: urgeToSmokeValue, classification: selectedMood)
        storageService.addUserSmokingSessionMetrics(entry: model)
        didSendEventClosure?(.done(model))
    }
    
    func didTapOnCloseButton() {
        didSendEventClosure?(.finish)
    }
    
    private var userSelectedAllFields: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($selectedMood, $urgeToSmokeValue)
            .map { $0.0 != nil && $0.1 != nil}
            .eraseToAnyPublisher()
    }
}

extension UserEmotionalStateViewModel {
    enum EventTypes {
        case done(UserSmokingSessionMetrics), finish
    }
}
 
