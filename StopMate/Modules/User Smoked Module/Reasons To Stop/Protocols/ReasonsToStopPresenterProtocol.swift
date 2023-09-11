//
//  ReasonsToStopPresenterProtocol.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.03.2023.
//

import Foundation

protocol ReasonsToStopPresenterProtocol: AnyObject {
    // Remove this because of using type enum
    var didSendEventClosure: ((ReasonsToStopModulePresenter.EventType) -> Void)? { get set }
    func showArrayOfReasons()
    func didTapDoneButton(reasons: [Int])
}
