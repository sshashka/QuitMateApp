//
//  VideoInfoView.swift
//  QuitMate
//
//  Created by Саша Василенко on 11.07.2023.
//

import SwiftUI
import SkeletonUI

struct VideoInfoView<ViewModel>: View where ViewModel: VideoInfoViewModelProtocol {
    @StateObject var vm: ViewModel
    var body: some View {
        VStack {
            if let result = vm.result {
                let snippet = result.items[0].snippet
                let statistics = result.items[0].statistics
                ScrollView {
                    VStack(alignment: .leading, spacing: Spacings.spacing20) {
                        VideoInfoViewImage(url: snippet.thumbnails.standard.url)
                        Text(snippet.title)
                            .fontStyle(.videoTitle)
                        ChanelAndVideoStatisticsView(chanelTitle: snippet.channelTitle, viewCount: statistics.viewCount, likeCount: statistics.likeCount)
                        Divider()
                        Text(snippet.description)
                            .fontStyle(.customSemibold16)
                        Divider()
                    }.padding([.bottom, .horizontal], Spacings.spacing30)
                }
                Button {
                    vm.didTapPlay()
                } label: {
                    HStack {
                        Image(systemName: SystemIconConstants.playFill)
                        Text(Localizables.VideosStrings.startWatching)
                            .fontStyle(.buttonsText)
                    }
                }
                .buttonStyle(StandartButtonStyle())
                .padding(.horizontal, Spacings.spacing30)
                Spacer(minLength: Spacings.spacing15)
            }
            
        }
        .skeleton(with: vm.state == .loading)
        .shape(type: .rectangle)
        .appearance(type: .solid(color: .backGroundColor))
        .onWillAppear {
            vm.willAppear()
        }
        .onWillDisappear {
            vm.willDisappear()
        }
        .safeAreaInset(edge: .top) {
            Color.clear
                .frame(height: 0)
                .background(.background)
                .border(.black)
        }
    }
}

struct VideoInfoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoInfoView(vm: VideoInfoViewModel(youtubeService: YoutubeApiService(), id: "ZDoCpWJ-Y28"))
    }
}




