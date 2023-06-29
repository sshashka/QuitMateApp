//
//  DetectingMoodModulePresenter.swift
//  QuitMate
//
//  Created by Саша Василенко on 16.04.2023.
//

import Foundation
import Combine

final class AutomaticMoodClassifierModulePresenter: MoodClassifierModulePresenterProtocol {
    private var disposeBag: Set<AnyCancellable> = Set<AnyCancellable>()
    weak var view: MoodClassifierViewControllerProtocol?
    let classifierService: UserMoodClassifierServiceProtocol
    
    init(view: MoodClassifierViewControllerProtocol, classifierService: UserMoodClassifierServiceProtocol) {
        self.view = view
        self.classifierService = classifierService
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
            self?.view?.classifierServiceDidSendResult(result: result)
        }
        .store(in: &disposeBag)
    }
}
