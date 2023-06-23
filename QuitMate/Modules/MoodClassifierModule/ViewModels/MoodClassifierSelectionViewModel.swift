//
//  MoodClassifierSelectionViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 31.05.2023.
//

import Foundation

final class MoodClassifierSelectionViewModel: ObservableObject {
    var didSendEventClosure: ((MoodClassifierSelectionViewModel.EventType) -> Void)?
    
    func didChooseClassifierType(selectedMethod: EventType) {
        self.didSendEventClosure?(selectedMethod)
    }
    
    enum EventType {
        case automatic
        case manual
    }
}
