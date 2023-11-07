//
//  MilestoneCompletedViewModel.swift
//  StopMate
//
//  Created by Саша Василенко on 25.10.2023.
//

import Foundation
import Combine

//MARK: - Protocol
protocol MilestoneCompletedViewModelProtocol {
    func didTapOnResetFinishingDate()
    func didTapOnDontChangeAnything()
}
//MARK: - Protocol implementation
final class MilestoneCompletedViewModel: ObservableObject, MilestoneCompletedViewModelProtocol {
    var didSendEvent: ((MilestoneCompletedViewModel.EventTypes) -> Void)?
    //MARK: - Public methods
    func didTapOnResetFinishingDate() {
        didSendEvent?(.resetFinishingDate)
    }
    
    func didTapOnDontChangeAnything() {
        didSendEvent?(.dontChangeAnything)
    }
}

//MARK: - Event types
extension MilestoneCompletedViewModel {
    enum EventTypes {
        case resetFinishingDate, dontChangeAnything
    }
}
