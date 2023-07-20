//
//  OpacityModifier.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.07.2023.
//

import SwiftUI

struct DisabledStateModifier: ViewModifier {
    private let isEnabled: Bool
    
    init(enabled: Bool) {
        self.isEnabled = enabled
    }
    
    func body(content: Content) -> some View {
        content
            .opacity(isEnabled ? 1.0 : 0.7)
            .disabled(isEnabled ? false : true)
    }
}
