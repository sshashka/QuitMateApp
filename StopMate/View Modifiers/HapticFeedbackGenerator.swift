//
//  HapticFeedbackGenerator.swift
//  StopMate
//
//  Created by Саша Василенко on 11.10.2023.
//

import SwiftUI

struct HapticFeedbackGenerator: ViewModifier {
    let event: VibrationEvent
    
    func body(content: Content) -> some View {
        content.onChange(of: true) { _ in
            let generator = UINotificationFeedbackGenerator()
            switch event {
            case .fail:
                generator.notificationOccurred(.error)
            case .success:
                generator.notificationOccurred(.success)
            case .hard:
                generator.notificationOccurred(.success)
            }
        }
    }
}
