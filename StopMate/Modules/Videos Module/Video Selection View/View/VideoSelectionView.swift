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
            CustomProgressView()
        case .loaded(let result):
            NavigationStack {
                ScrollView {
                    LazyVStack(spacing: Spacings.spacing15) {
                        // Using this instead of ForEach(result) because I need to get id of a view
                        ForEach(0..<result.count, id: \.self) {i in
                            VideoSelectionCell(url: result[i].snippet.thumbnails.medium.url, title: result[i].snippet.title, descriplion: result[i].snippet.description, duration: "\(result[i].snippet.publishedAt)")
                                .onTapGesture {
                                    viewModel.didSelectVideo(at: i)
                                }
                                .onAppear{
                                    viewModel.loadMoreVideos(latestItem: i)
                                }
                        }
                        if viewModel.isLoadingMoreVideos {
                            ProgressView()
                                .padding()
                        }
                    }
                    .padding(.horizontal, Spacings.spacing15)
                        
                }.navigationTitle("Videos")
            }
            .toolbarBackground(.automatic, for: .navigationBar)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct VideoSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let service = YoutubeApiService()
        VideoSelectionView(viewModel: VideoSelectionViewModel(youtubeService: service))
    }
}
