//
//  ProfileImagePic.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.07.2023.
//

import SwiftUI

struct ProfileImagePic: View {
    var data: Data?
    var body: some View {
        switch data.flatMap(UIImage.init) {
        case let .some(image):
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
        case .none:
            Image(IconConstants.noProfilePic)
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 150, height: 150)
        }
    }
}

struct ProfileImagePic_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImagePic()
    }
}
