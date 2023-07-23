//
//  VideoCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.07.2023.
//

import SwiftUI

struct VideoSelectionCell: View {
    let url: String
    let title: String
    let descriplion: String
    let duration: String
    var body: some View {
        ZStack {
            HStack {
                AsyncImage(url: URL(string: url)) { phaze in
                    switch phaze {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        // Add an image crop
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius))
                    case .failure:
                        EmptyView()
                    @unknown default:
                        EmptyView()
                    }
                }
                
                VStack(alignment: .leading) {
                    Text(title)
                        .fontStyle(.videoTitle)
                        .lineLimit(2)
                    Text(descriplion)
                        .fontStyle(.greyHeaderText)
                        .foregroundColor(.gray)
                        .lineLimit(3)
                }
            }.padding()
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .opacity(0.2)
        }
    }
}

struct VideoCell_Previews: PreviewProvider {
    static var previews: some View {
        VideoSelectionCell(url: "https://img.youtube.com/vi/ZDoCpWJ-Y28/mqdefault.jpg", title: "DAFDSFSDFFDSFDSF", descriplion: "SAdfsfsfsd", duration: "232423")
    }
}
