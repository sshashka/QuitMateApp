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
            Image("").fromData(from: viewModel.image)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
            Text(viewModel.name)
                .modifier(TextViewModifier(font: .poppinsMedium, size: 16))
            Text(viewModel.email)
                .modifier(TextViewModifier(font: .poppinsMedium, size: 14))
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
