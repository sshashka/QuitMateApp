//
//  SettingsViewProfileHeaderView.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.05.2023.
//

import SwiftUI

struct SettingsViewProfileHeaderView: View {
    @StateObject var viewModel = SettingsViewModel()
    var body: some View {
        VStack(spacing: Spacings.spacing10) {
            Image("Tokyo")
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            TextView(text: "$viewModel.userModel.first.name", font: .poppinsMedium, size: 16)
            TextView(text: "alex.underbill@example.com", font: .poppinsMedium, size: 14)
                .foregroundColor(.gray)
        }
        .padding()
    }
}

struct SettingsViewProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsViewProfileHeaderView()
    }
}
