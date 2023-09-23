//
//  YoutubeApiService.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.07.2023.
//

import Foundation
import Combine


protocol YoutubeApiServiceProtocol: AnyObject {
    func getVideos() -> AnyPublisher<YoutubeAPIResponce, Never>
    func getVideoInformation(for id: String) -> AnyPublisher<YoutubeAPIVideoDetailsResponce, Never>
    func loadMoreVideos(nextPageToken: String) -> AnyPublisher<YoutubeAPIResponce, Never>
}

class YoutubeApiService: YoutubeApiServiceProtocol {
    private func getApiKey() -> String {
        // Put your own key here
        return ""
    }
    
    private var disposeBag = Set<AnyCancellable>()
        func getVideos() -> AnyPublisher<YoutubeAPIResponce, Never> {
            let subject = PassthroughSubject<YoutubeAPIResponce, Never>()
            var key: String = getApiKey()
            let urlString = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=id&part=contentDetails&part=snippet&part=status&playlistId=PLvrp9iOILTQZNKggn9HlTpQRSE7deeA6_&key=\(key)&maxResults=10"
            let url = URL(string: urlString)
    //        guard let url = url else { return }
            let session = URLSession.shared
            session
                .dataTaskPublisher(for: url!)
                .map {$0.data}
                .decode(type: YoutubeAPIResponce.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
                .sink(receiveCompletion: { completion in
                        print("\(completion)")
                }, receiveValue: { data in
                    subject.send(data)
                })
                .store(in: &disposeBag)
            return subject.eraseToAnyPublisher()
        }
    
    func loadMoreVideos(nextPageToken: String) -> AnyPublisher<YoutubeAPIResponce, Never> {
        let subject = PassthroughSubject<YoutubeAPIResponce, Never>()
        let key = getApiKey()
        let urlString = "https://youtube.googleapis.com/youtube/v3/playlistItems?part=id&part=contentDetails&part=snippet&part=status&playlistId=PLvrp9iOILTQZNKggn9HlTpQRSE7deeA6_&key=\(key)&maxResults=10&pageToken=\(nextPageToken)"
        let url = URL(string: urlString)
        let session = URLSession.shared
        session
            .dataTaskPublisher(for: url!)
            .map {$0.data}
            .decode(type: YoutubeAPIResponce.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: { completion in
                    print("\(completion)")
            }, receiveValue: { data in
                subject.send(data)
            })
            .store(in: &disposeBag)
        return subject.eraseToAnyPublisher()
    }
    
    func getVideoInformation(for id: String) -> AnyPublisher<YoutubeAPIVideoDetailsResponce, Never> {
        let subject = PassthroughSubject<YoutubeAPIVideoDetailsResponce, Never>()
        let key = getApiKey()
        let urlString = "https://youtube.googleapis.com/youtube/v3/videos?part=contentDetails%2C%20id%2C%20snippet%2C%20statistics%2C%20topicDetails&id=\(id)&key=\(key)"
        print(urlString)
        let url = URL(string: urlString)
        let session = URLSession.shared
        session.dataTaskPublisher(for: url!)
            .map{$0.data}
            .decode(type: YoutubeAPIVideoDetailsResponce.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
            .sink(receiveCompletion: {
                print($0)
            }, receiveValue: { data in
                subject.send(data)
            })
            .store(in: &disposeBag)
        return subject.eraseToAnyPublisher()
    }
    
    deinit {
        print("\(self) deinited")
    }
}
