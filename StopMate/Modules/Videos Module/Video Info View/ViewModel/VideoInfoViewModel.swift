//
//  VideoInfoViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 13.07.2023.
//

import Foundation
import Combine

enum VideoInfoViewModelStates {
    case loading, loaded
}

protocol VideoInfoViewModelProtocol: AnyObject, ObservableObject {
    var state: VideoInfoViewModelStates { get }
    var result: YoutubeAPIVideoDetailsResponce? { get }
    func didTapPlay()
    func willDisappear()
    func willAppear()
    func start()
}

final class VideoInfoViewModel: VideoInfoViewModelProtocol {
    var didSendEventClosure: ((VideoInfoViewModel.EventTypes) -> Void)?
    private var disposeBag = Set<AnyCancellable>()
    private let youtubeService: YoutubeApiServiceProtocol
    private let id: String
    private (set) var result: YoutubeAPIVideoDetailsResponce? {
        didSet {
            guard result != nil else { return }
            // I do this so user does not see a jump from UINavigationController
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.state = .loaded
            }
        }
    }
    @Published private (set) var state: VideoInfoViewModelStates = .loading
    init(youtubeService: YoutubeApiServiceProtocol, id: String) {
        self.youtubeService = youtubeService
        self.id = id
        getVideoInfo()
    }
    
    func start() {
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
    
    func willDisappear() {
        didSendEventClosure?(.willDisappear)
    }
    
    func willAppear() {
        didSendEventClosure?(.willAppear)
    }
}

extension VideoInfoViewModel {
    enum EventTypes {
        case loadVideo(String), willDisappear, willAppear
    }
}
