//
//  SUIButtonStyle.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct StandartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color(ColorConstants.buttonsColor))
            .cornerRadius(10)
            .font(.custom(FontsEnum.poppinsSemiBold.rawValue, size: 14))
    }
    
}
