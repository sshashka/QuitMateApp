//
//  SettingsButton.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.07.2023.
//

import SwiftUI

struct SettingsButton: View {
    @EnvironmentObject var viewModel: MainScreenViewModel
    var body: some View {
        Button {
            viewModel.didTapOnSettings()
        } label: {
            Image(systemName: SystemIconConstants.gearShape)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 35, maxHeight: 35)
                .foregroundColor(Color(ColorConstants.labelColor))
        }
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton()
    }
}
