//
//  MoodClassifierModuleViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import Foundation

protocol ManualMoodClassifierModuleViewModelProtocol: AnyObject, ObservableObject {
    var moodsArray: [ClassifiedMood] { get }
    var selectedMood: ClassifiedMood? { get set }
    func handleMoodSelection(selectedMood: ClassifiedMood?)
    func didTapOnDoneButton()
}

final class ManualMoodClassifierModuleViewModel: ManualMoodClassifierModuleViewModelProtocol {
    private let storageService: FirebaseStorageServiceProtocol
    @Published var moodsArray: [ClassifiedMood] = []
    @Published var selectedMood: ClassifiedMood? = nil
    var didSendEndEventClosure: ((ManualMoodClassifierModuleViewModel.EndEvent) -> Void)?
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        let moods = ClassifiedMood.allCases
        moodsArray = moods
    }
    
    func handleMoodSelection(selectedMood: ClassifiedMood?) {
        self.selectedMood = selectedMood
    }
    
    func didTapOnDoneButton() {
        guard let selectedMood = selectedMood else { return }
        storageService.uploadNewUserMood(mood: selectedMood)
        self.didSendEndEventClosure?(.moodClassifier)
    }
}

extension ManualMoodClassifierModuleViewModel {
    enum EndEvent { case moodClassifier }
}
