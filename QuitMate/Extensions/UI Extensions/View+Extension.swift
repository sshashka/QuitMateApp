//
//  View+Extension.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.06.2023.
//

import SwiftUI

extension View {
    func fontStyle(_ style: PoppinsTextStyles) -> some View {
        // Looks weird 
        modifier(TextViewModifier(style.getTextStyle(style: style)))
    }
}
