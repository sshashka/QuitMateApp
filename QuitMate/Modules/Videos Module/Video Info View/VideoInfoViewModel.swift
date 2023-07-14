//
//  VideoInfoViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.07.2023.
//

import Foundation
import Combine

class VideoInfoViewModel: ObservableObject {
    enum VideoInfoViewModelStates {
        case loading, loaded(YoutubeAPIVideoDetailsResponce)
    }
    var didSendEventClosure: ((VideoInfoViewModel.EventTypes) -> Void)?
    private var disposeBag = Set<AnyCancellable>()
    private let youtubeService: YoutubeApiServiceProtocol
    private let id: String
    private var result: YoutubeAPIVideoDetailsResponce? {
        didSet {
            guard let result = result else { return }
            print(result)
            self.state = .loaded(result)
        }
    }
    @Published private (set) var state: VideoInfoViewModelStates = .loading
    init(youtubeService: YoutubeApiServiceProtocol, id: String) {
        self.youtubeService = youtubeService
        self.id = id
        getVideoInfo()
    }
    
    private func getVideoInfo() {
        youtubeService.getVideoInformation(for: id)
            .receive(on: RunLoop.main)
            .sink {[weak self] result in
            self?.result = result
        }.store(in: &disposeBag)
    }
    
    func didTapPlay() {
        guard let result = result else { return }
        didSendEventClosure?(.loadVideo(result.items[0].id))
    }
}

extension VideoInfoViewModel {
    enum EventTypes {
        case loadVideo(String)
    }
}
