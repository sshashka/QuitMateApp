//
//  MoodClassifierButton.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct MoodClassifierButton: View {
    @State var buttonPressed: Bool = false
    // I do this to automaticly show/hide chechmark on selection, feel that this is wrong approach
    var labelText: ClassifiedMood
    @Binding var selectedMood: ClassifiedMood?
    
    var body: some View {
        Button {
            buttonPressed.toggle()
            selectedMood = buttonPressed ? labelText : nil
        } label: {
            HStack {
                Text(labelText.rawValue)
                    .modifier(TextViewModifier(font: .poppinsSemiBold, size: 14))
                Image(systemName: labelText == selectedMood ? "checkmark" : "")
            }
        }
        .buttonStyle(StandartButtonStyle())
    }
}

struct MoodClassifierButton_Previews: PreviewProvider {
    static var previews: some View {
        @State var classifiedMood: ClassifiedMood? = ClassifiedMood(rawValue: "Happy")
        MoodClassifierButton(labelText: ClassifiedMood(rawValue: "Happy")!, selectedMood: $classifiedMood)
    }
}
