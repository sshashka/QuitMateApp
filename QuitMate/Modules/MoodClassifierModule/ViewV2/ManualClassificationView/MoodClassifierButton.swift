//
//  MoodClassifierButton.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct MoodClassifierButton: View {
    @State var buttonPressed: Bool = false
    @Binding var labelText: ClassifiedMood
    @Binding var selectedMood: ClassifiedMood?
    
    var body: some View {
        Button {
            buttonPressed.toggle()
            selectedMood = buttonPressed ? labelText : nil
        } label: {
            Group {
                HStack {
                    Text(labelText.rawValue)
                        .modifier(TextViewModifier(font: .poppinsSemiBold, size: 14))
                    Image(systemName: buttonPressed ? "checkmark" : "")
                }
            }
        }
        .buttonStyle(ButtonWithCheckMarkButtonStyle())
    }
}
