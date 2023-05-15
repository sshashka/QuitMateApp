//
//  MoodClassifierModuleViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import Foundation


class MoodClassifierModuleViewModel: ObservableObject {
    @Published var moodsArray: [ClassifiedMood] = []
    @Published var selectedMood: ClassifiedMood? = nil
    var didSendEndEventClosure: ((MoodClassifierModuleViewModel.EndEvent) -> Void)?
    
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

extension MoodClassifierModuleViewModel {
    enum EndEvent { case moodClassifier }
}
