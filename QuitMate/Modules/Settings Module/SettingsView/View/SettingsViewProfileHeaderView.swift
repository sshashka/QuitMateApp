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
            createImage()
                .resizable()
                .clipShape(Circle())
                .frame(width: 100, height: 100)
            Text(viewModel.name)
                .modifier(TextViewModifier(font: .poppinsMedium, size: 16))
            Text(viewModel.email)
                .modifier(TextViewModifier(font: .poppinsMedium, size: 14))
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    private func createImage() -> Image {
        let data = viewModel.image
        guard let data else { return Image(IconConstants.noProfilePic)}
        let UIKitImage = UIImage(data: data)
        // remove force unwrap
        guard let UIKitImage else { return Image(IconConstants.noProfilePic)}
        return Image(uiImage: UIKitImage)
    }
}

//struct SettingsViewProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsViewProfileHeaderView()
//    }
//}
