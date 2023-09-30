//
//  SettingsViewProfileHeaderView.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.05.2023.
//

import SwiftUI
import UIKit

struct SettingsViewProfileHeaderView: View {
    @StateObject var viewModel: HeaderViewViewModel
    var body: some View {
        VStack(spacing: Spacings.spacing10) {
            ProfileImagePic(data: viewModel.image)
            Text(viewModel.name)
                .modifier(TextViewModifier(font: .medium, size: 16))
            Text(viewModel.email)
                .modifier(TextViewModifier(font: .medium, size: 14))
                .foregroundColor(.gray)
        }
        .padding()
    }
}

//struct SettingsViewProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsViewProfileHeaderView()
//    }
//}
