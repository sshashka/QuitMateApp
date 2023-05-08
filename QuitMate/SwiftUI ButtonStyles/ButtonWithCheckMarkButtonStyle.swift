//
//  ButtonWithCheckMarkButtonStyle.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct ButtonWithCheckMarkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color(ColorConstants.purpleColor))
            .cornerRadius(10)
    }
}
