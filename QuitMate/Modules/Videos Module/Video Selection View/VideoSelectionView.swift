//
//  VideoSelectionView.swift
//  QuitMate
//
//  Created by Саша Василенко on 07.07.2023.
//

import SwiftUI

struct VideoSelectionView: View {
    @StateObject var viewModel: VideoSelectionViewModel
    var body: some View {
        switch viewModel.state {
        case .loading:
            GroupBox {
                ProgressView()
                    .padding()
            }
        case .loaded(let result):
            ScrollView {
                LazyVStack(spacing: Spacings.spacing15) {
                    ForEach(0..<result.count, id: \.self) {i in
                        VideoCell(url: result[i].snippet.thumbnails.medium.url, title: result[i].snippet.title, descriplion: result[i].snippet.description, duration: "\(result[i].snippet.publishedAt)")
                            .onTapGesture {
                                viewModel.didSelectVideo(at: i)
                            }
//                            .onAppear{
//                                viewModel.loadMoreVideos()
//                            }
                    }
                }.padding(Spacings.spacing10)
            }
        }
    }
}

struct VideoSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let service = YoutubeApiService()
        VideoSelectionView(viewModel: VideoSelectionViewModel(youtubeService: service))
    }
}
