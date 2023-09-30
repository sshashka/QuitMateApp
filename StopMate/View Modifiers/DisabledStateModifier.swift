//
//  OpacityModifier.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.07.2023.
//

import SwiftUI

struct DisabledStateModifier: ViewModifier {
    private let isEnabled: Bool
    
    init(_ state: Bool) {
        self.isEnabled = state
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isEnabled ? 1.0 : 0.6)
            .disabled(!isEnabled)
    }
}
