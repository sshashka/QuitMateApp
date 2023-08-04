//
//  VideoInfoView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.07.2023.
//

import SwiftUI

struct VideoInfoView: View {
    @StateObject var vm: VideoInfoViewModel
    var body: some View {
        switch vm.state {
        case .loading:
            ProgressView()
        case .loaded(let result):
            let snippet = result.items[0].snippet
            let statistics = result.items[0].statistics
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: Spacings.spacing20) {
                        AsyncImage(url: URL(string: snippet.thumbnails.standard.url)) { phaze in
                            switch phaze {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                EmptyView()
                            @unknown default:
                                EmptyView()
                            }
                        }
                        Text(snippet.title)
                            .fontStyle(.videoTitle)
                        HStack {
                            Text(snippet.channelTitle)
                            Spacer()
                            ZStack {
                                HStack {
                                    Image(systemName: "play.fill")
                                    Text(statistics.viewCount)
                                    
                                    Image(systemName: "hand.thumbsup.fill")
                                    Text(statistics.likeCount)
                                }
                                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                                    .stroke(lineWidth: 1)
                            }
                        }.fontStyle(.textViewText)
                        Divider()
                            .frame(height: 5)
                        Text(snippet.description)
                            .fontStyle(.poppinsSemibold16)
                        Divider()
                            .frame(height: 5)
                    }.padding([.bottom, .horizontal], Spacings.spacing30)
                }
                Button {
                    vm.didTapPlay()
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Text("Start watching")
                            .fontStyle(.buttonsText)
                    }
                }.buttonStyle(StandartButtonStyle())
                    .padding(.horizontal, Spacings.spacing30)
                Spacer(minLength: Spacings.spacing15)
            }.onWillDisappear {
                vm.onDisappear()
            }
            .safeAreaInset(edge: .top) {
                Color.clear
                    .frame(height: 0)
                    .background(.background)
                    .border(.black)
            }
        }
    }
}

struct VideoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoInfoView(vm: VideoInfoViewModel(youtubeService: YoutubeApiService(), id: "ZDoCpWJ-Y28"))
    }
}
