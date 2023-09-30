//
//  DetectingMoodModulePresenter.swift
//  QuitMate
//
//  Created by Саша Василенко on 16.04.2023.
//

import Foundation
import Combine

final class AutomaticMoodClassifierModulePresenter: MoodClassifierModulePresenterProtocol {
    var didSendEventClosure: ((AutomaticMoodClassifierModulePresenter.EventTypes) -> Void)?
    private var disposeBag: Set<AnyCancellable> = Set<AnyCancellable>()
    weak var view: MoodClassifierViewControllerProtocol?
    private let classifierService: UserMoodClassifierServiceProtocol
    private let storageService: FirebaseStorageServiceProtocol
    private var classifiedMood: String = ""
    
    init(view: MoodClassifierViewControllerProtocol, classifierService: UserMoodClassifierServiceProtocol, storageService: FirebaseStorageServiceProtocol) {
        self.view = view
        self.classifierService = classifierService
        self.storageService = storageService
    }
    
    func userDidTakePicture(image: Data) {
        validateImage(image: image)
    }
    
    private func validateImage(image: Data) {
        classifierService.checkIfFacePresent(image: image) {[weak self] result in
            switch result {
            case .succes:
                self?.detectMood(image: image)
            case .failure:
                self?.view?.showValidationFailureAlert(message: "Validation failed. Try again!")
            }
        }
    }
    private func detectMood(image: Data) {
        classifierService.classifyImage(image: image)
        classifierService.classificationPublisher
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                self?.classifiedMood = result
            self?.view?.classifierServiceDidSendResult(result: result)
        }
        .store(in: &disposeBag)
    }
    
    func doneButtonDidTap() {
        guard let mood = ClassifiedMood(rawValue: classifiedMood) else { return }
        storageService.uploadNewUserMood(mood: mood)
        didSendEventClosure?(.done)
    }
    
    func switchToManualClassifierDidTap() {
        didSendEventClosure?(.switchToManualClassifier)
    }
}

extension AutomaticMoodClassifierModulePresenter {
    enum EventTypes {
        case done, switchToManualClassifier
    }
}
