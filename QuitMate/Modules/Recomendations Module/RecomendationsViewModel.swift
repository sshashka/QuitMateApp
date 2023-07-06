//
//  RecomendationsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.06.2023.
//

import Combine
import OpenAI
import Foundation

final class RecomendationsViewModel: ObservableObject {
    enum State {
        case loading
        case loaded(String)
    }
    var didSendEventClosure: ((RecomendationsViewModel.EventType) -> Void)?
    // rename
    var typeOfGeneration: RecomendationsCoordinator.Types = .moods
    @Published var state: State = .loading
    private var disposeBag: Set<AnyCancellable> = Set<AnyCancellable>()
    private let storageService: FirebaseStorageServiceProtocol
    private var userData: User? {
        didSet {
            guard statsData != nil else { return }
            generateResponse()
        }
    }
    private var statsData: [ChartModel]? {
        didSet {
            guard userData != nil else { return }
            generateResponse()
        }
    }
    
    init(storageService: FirebaseStorageServiceProtocol, type: RecomendationsCoordinator.Types = .moods) {
        self.storageService = storageService
        self.typeOfGeneration = type
        getUserData()
    }
    
    private func getUserData() {
        state = .loading
        storageService.getUserModel()
            .sink { _ in
                // Add completion handling
                print("Error")
            } receiveValue: {[weak self] users in
                self?.userData = users.first
            }.store(in: &disposeBag)
        
        storageService.getChartsData()
            .sink { _ in
                print("Error")
            } receiveValue: {[weak self] data in
                self?.statsData = data
            }.store(in: &disposeBag)
        
    }
    
    func generateResponse() {
        state = .loading
        guard let userData = userData else { return }
        guard let statsData = statsData else { return }
        let name = userData.name
        // Remove force unwrap
        let moods = statsData.map {
            $0.classification.classifiedMood!.rawValue
        }
        let daysWithoutSmoking = userData.daysWithoutSmoking
        // Please put your own token here because OpenAI doesnt allow to publish them
        let openAi = OpenAI(apiToken: "")
        // Fix regenerating response
        let query: CompletionsQuery
        
        switch typeOfGeneration {
        case .moods:
            query = CompletionsQuery(model: .textDavinci_003, prompt: "Hello there, my name is \(name) I am a smoker and I try to quit. I don`t smoke for \(daysWithoutSmoking) days and I`m proud of it I do diary of my moods during the process and here they are \(moods) can u do an small analysis of my moods for me, provide me some help how not to start smoking again, and afer it add just something to cheer me up. Thanks", temperature: 1.0, maxTokens: 1000)

        case .smoking:
            let reasons = UserDefaults.standard.object(forKey: "UserSmoked")
            query = CompletionsQuery(model: .textDavinci_003, prompt: "Hello there, my name is \(name) I am a smoker and I try to quit. I don`t smoke for \(daysWithoutSmoking) days and I`m proud of it I do diary of my moods during the process and here they are \(moods) can u do an small analysis of my moods for me, provide me some cheer words because I started smoking again, because i ve been feeling \(reasons ?? "Bad") and dont want to this happen again add just something to cheer me up. Thanks", temperature: 1.0, maxTokens: 1000)
        }
        
        openAi.completions(query: query)
            .receive(on: RunLoop.main)
            .sink {
                print($0)
            } receiveValue: { [weak self] result in
                let results = result.choices.map {
                    $0.text
                }
                guard let firstResponse = results.first else { return }
                self?.state = .loaded(firstResponse)
                print(firstResponse)
            }.store(in: &disposeBag)
    }
    
    func didTapDone() {
        didSendEventClosure?(.finish)
    }
}

extension RecomendationsViewModel {
    enum EventType {
        case finish
    }
}
