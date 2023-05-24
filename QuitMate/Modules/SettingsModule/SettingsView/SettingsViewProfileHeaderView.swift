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
            TextView(text: viewModel.name, font: .poppinsMedium, size: 16)
            TextView(text: viewModel.email, font: .poppinsMedium, size: 14)
                .foregroundColor(.gray)
        }
        .padding()
    }
    
    private func createImage() -> Image {
        let data = viewModel.image
        guard let data = data else { return Image("3")}
        let UIKitImage = UIImage(data: data)
        return Image(uiImage: UIKitImage!)
    }
}

//struct SettingsViewProfileHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsViewProfileHeaderView()
//    }
//}
