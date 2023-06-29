//
//  Publisher<Bool,Never>Extension.swift
//  QuitMate
//
//  Created by Саша Василенко on 09.06.2023.
//

import Combine
import SwiftUI
import UIKit

extension Publisher where Output == Bool, Failure == Never {
    func mapToFieldInputColor() -> AnyPublisher<UIColor?, Never> {
        map { isValid -> UIColor? in
            isValid ? .lightGray : .systemRed
        }
        .eraseToAnyPublisher()
    }
}

extension Publisher where Output == Bool, Failure == Never {
    func mapToFieldInputColor() -> AnyPublisher<Color?, Never> {
        map { isValid -> Color? in
            isValid ? Color(ColorConstants.gray) : Color(ColorConstants.red)
        }
        .eraseToAnyPublisher()
    }
    
    
}

//extension Publisher where Output == String, Failure == Never {
//    func validateEmail() -> AnyPublisher<Bool, Never> {
//        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
//        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
////            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
//            return map { email -> Bool in
//                emailPredicate.evaluate(with: email)
//            }
//            .eraseToAnyPublisher()
//    }
//}
