//
//  DetectingMoodModulePresenterProtocol.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.04.2023.
//

import Foundation

protocol MoodClassifierModulePresenterProtocol: AnyObject {
    var didSendEventClosure: ((AutomaticMoodClassifierModulePresenter.EventTypes) -> Void)? { get set}
    func userDidTakePicture(image: Data)
    func doneButtonDidTap()
    func switchToManualClassifierDidTap()
//    func 
}
