//
//  VideoSelectionViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.07.2023.
//

import Foundation
import Combine

class VideoSelectionViewModel: ObservableObject {
    private let youtubeService: YoutubeApiService
    private var disposeBag = Set<AnyCancellable>()
    var didSendEvetClosure: ((VideoSelectionViewModel.EventTypes) -> Void)?
    private var videosList: YoutubeAPIResponce? {
        didSet {
            guard let videosList = videosList else { return }
            self.state = .loaded(videosList)
        }
    }
    @Published var state: VideoSelectionViewModelStates
    
    enum VideoSelectionViewModelStates {
        case loading, loaded(YoutubeAPIResponce)
    }
    
    init(youtubeService: YoutubeApiService) {
        self.youtubeService = youtubeService
        self.state = .loading
        getVideosList()
    }
    
    func getVideosList() {
        youtubeService.getVideos()
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] response in
                self?.videosList = response
            })
            .store(in: &disposeBag)
    }
    
    func didSelectVideo(at index: Int) {
        guard let videosList else { return }
        let selectedVideoId = videosList.items[index].contentDetails.videoID
        didSendEvetClosure?(.didSelectVideo(selectedVideoId))
    }
}

extension VideoSelectionViewModel {
    enum EventTypes {
        case didSelectVideo(String)
    }
}
