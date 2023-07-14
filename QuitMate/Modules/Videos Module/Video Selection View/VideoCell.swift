//
//  VideoCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.07.2023.
//

import SwiftUI

struct VideoCell: View {
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
                        image.resizable()
                            .aspectRatio(4/3, contentMode: .fit)
//                            .frame(maxHeight: 200)
//                            .fixedSize()
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
                .opacity(0.1)
        }
    }
}

struct VideoCell_Previews: PreviewProvider {
    static var previews: some View {
        VideoCell(url: "https://img.youtube.com/vi/ZDoCpWJ-Y28/mqdefault.jpg", title: "DAFDSFSDFFDSFDSF", descriplion: "SAdfsfsfsd", duration: "232423")
    }
}
