//
//  VideoInfoViewImage.swift
//  StopMate
//
//  Created by Саша Василенко on 17.08.2023.
//

import SwiftUI

struct VideoInfoViewImage: View {
    let url: String
    var body: some View {
        AsyncImage(url: URL(string: url)) { phaze in
            switch phaze {
            case .empty:
                ProgressView()
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .mask(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius).padding(.vertical, Spacings.spacing25))
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct VideoInfoViewImage_Previews: PreviewProvider {
    static var previews: some View {
        VideoInfoViewImage(url: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fuseyourloaf.com%2Fblog%2Fswiftui-preview-data%2F&psig=AOvVaw142h6wermhZniySRKRgofy&ust=1692316576235000&source=images&cd=vfe&opi=89978449&ved=0CBAQjRxqFwoTCJCh0dSw4oADFQAAAAAdAAAAABAE")
    }
}
