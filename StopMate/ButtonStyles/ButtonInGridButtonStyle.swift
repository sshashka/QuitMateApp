//
//  ButtonInGridButtonStyle.swift
//  StopMate
//
//  Created by Саша Василенко on 31.08.2023.
//

import SwiftUI

struct ButtonInGridButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 25)
            .padding()
            .foregroundColor(.white)
            .background(Color.buttonsPurpleColor)
            .cornerRadius(10)
            .font(.custom(FontsEnum.semiBold.rawValue, size: 14))
    }
}

