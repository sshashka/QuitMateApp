//
//  MoodClassifierModuleViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import Foundation


final class ManualMoodClassifierModuleViewModel: ObservableObject {
    @Published var moodsArray: [ClassifiedMood] = []
    @Published var selectedMood: ClassifiedMood? = nil
    var didSendEndEventClosure: ((ManualMoodClassifierModuleViewModel.EndEvent) -> Void)?
    
    init() {
        let moods = ClassifiedMood.allCases
        moodsArray = moods
    }
    
    func handleMoodSelection(selectedMood: ClassifiedMood?) {
        self.selectedMood = selectedMood
    }
    
    func didTapOnDoneButton() {
        guard let selectedMood = selectedMood else { return }
        FirebaseStorageService().uploadNewUserMood(mood: selectedMood)
        self.didSendEndEventClosure?(.moodClassifier)
    }
}

extension ManualMoodClassifierModuleViewModel {
    enum EndEvent { case moodClassifier }
}
