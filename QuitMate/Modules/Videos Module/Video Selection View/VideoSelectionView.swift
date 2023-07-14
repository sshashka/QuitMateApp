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
            ProgressView()
        case .loaded(let result):
            ScrollView {
                LazyVStack(spacing: Spacings.spacing15) {
                    ForEach(0..<result.items.count, id: \.self) {i in
                        VideoCell(url: result.items[i].snippet.thumbnails.standard.url, title: result.items[i].snippet.title, descriplion: result.items[i].snippet.description, duration: "\(result.items[i].snippet.publishedAt)")
                            .onTapGesture {
                                viewModel.didSelectVideo(at: i)
                            }
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
