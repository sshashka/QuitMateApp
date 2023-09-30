//
//  VideoSelectionViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.07.2023.
//

import Foundation
import Combine

enum VideoSelectionViewModelStates {
    case loading, loaded([Item])
}

protocol VideoSelectionViewModelProtocol: AnyObject, ObservableObject {
    var videoInfo: [Item] { get }
    var state: VideoSelectionViewModelStates { get }
    var isLoadingMoreVideos: Bool { get }
    func start()
    func didSelectVideo(at index: Int)
    func loadMoreVideos(latestItem: Int)
}

final class VideoSelectionViewModel: VideoSelectionViewModelProtocol {
    private let youtubeService: YoutubeApiService
    private var disposeBag = Set<AnyCancellable>()
    var didSendEvetClosure: ((VideoSelectionViewModel.EventTypes) -> Void)?
    private var videosList: YoutubeAPIResponce? {
        didSet {
            guard let videosList = videosList else { return }
            self.videoInfo.append(contentsOf: videosList.items)
        }
    }
    
    var videoInfo: [Item] = [Item]() {
        didSet {
            guard !videoInfo.isEmpty else { return }
            state = .loaded(videoInfo)
        }
    }
    @Published private (set) var state: VideoSelectionViewModelStates
    @Published private (set) var isLoadingMoreVideos: Bool = false
    
    init(youtubeService: YoutubeApiService) {
        self.youtubeService = youtubeService
        self.state = .loading
        start()
    }
    
    func start() {
        getVideosList()
    }
    
    private func getVideosList() {
        youtubeService.getVideos()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { [weak self] response in
                self?.videosList = response
            })
            .store(in: &disposeBag)
    }
    
    func didSelectVideo(at index: Int) {
//        guard let videosList else { return }
        let selectedVideoId = videoInfo[index].contentDetails.videoID
        didSendEvetClosure?(.didSelectVideo(selectedVideoId))
    }
    
    func loadMoreVideos(latestItem: Int) {
        
        guard let videosList else { return }
        // Might be more elegant solution
        //Should have been a check if items are the same, but that needs model to be equtable
        guard videoInfo.count == latestItem + 1 else { return }
        let token = videosList.nextPageToken
        guard let token else { return }
        isLoadingMoreVideos = true
        youtubeService.loadMoreVideos(nextPageToken: token)
            .receive(on: RunLoop.main)
            .sink { [weak self] videos in
                self?.videosList = videos
                self?.isLoadingMoreVideos = false
            }.store(in: &disposeBag)
    }
}

extension VideoSelectionViewModel {
    enum EventTypes {
        case didSelectVideo(String)
    }
}
