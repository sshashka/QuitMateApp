//
//  Vibrate.swift
//  StopMate
//
//  Created by Саша Василенко on 22.08.2023.
//

import UIKit
import SwiftUI

enum VibrationEvent {
    case fail, success
}


struct VibrationModifier: ViewModifier {
    let event: VibrationEvent
    let generator = UINotificationFeedbackGenerator()
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                switch event {
                case .fail:
                    generator.notificationOccurred(.error)
                case .success:
                    generator.notificationOccurred(.success)
                }
            }
    }
}
