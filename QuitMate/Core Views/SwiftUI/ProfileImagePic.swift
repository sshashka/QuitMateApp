//
//  ProfileImagePic.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.07.2023.
//

import SwiftUI

struct ProfileImagePic: View {
    var image: Data?
    var body: some View {
        createImage()
            .resizable()
            .clipped()
            .clipShape(Circle())
            .aspectRatio(contentMode: .fit)
            .frame(idealWidth: 150, maxWidth: 200, idealHeight: 150, maxHeight: 200)
//            .fixedSize()
    }
    
    private func createImage() -> Image {
        guard let image else { return Image(IconConstants.noProfilePic)}
        let UIKitImage = UIImage(data: image)
        guard let UIKitImage else { return Image(IconConstants.noProfilePic)}
        return Image(uiImage: UIKitImage)
    }
}

struct ProfileImagePic_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImagePic()
    }
}
