//
//  RecomendationsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.06.2023.
//

import Combine
import OpenAI
import Foundation

enum RecomendationsViewModelState {
    case loading
    case loaded
}

protocol RecomendationsViewModelProtocol: AnyObject, ObservableObject {
    var state: RecomendationsViewModelState { get }
    var recomendation: String { get }
    var doneAndRegenerateButtonsEnabled: Bool { get set }
    func didTapDone()
    func generateResponse()
    func start()
}

final class RecomendationsViewModel: RecomendationsViewModelProtocol {
    enum TypeOfRecomendation {
        case moodRecomendation
        case timerResetRecomendation([String], UserSmokingSessionMetrics?)
    }
    var didSendEventClosure: ((RecomendationsViewModel.EventType) -> Void)?
    private var typeOfGenerationEvent: TypeOfRecomendation
    @Published var state: RecomendationsViewModelState = .loading {
        didSet {
            guard state == .loaded else { doneAndRegenerateButtonsEnabled = false; return }
            doneAndRegenerateButtonsEnabled = true
        }
    }
    @Published var recomendation: String = ""
    @Published var doneAndRegenerateButtonsEnabled: Bool = false
    
    private var disposeBag: Set<AnyCancellable> = Set<AnyCancellable>()
    private let storageService: FirebaseStorageServiceProtocol
    private var userData: User? {
        didSet {
            guard statsData != nil else { return }
            generateResponse()
        }
    }
    private var statsData: [UserMoodModel]? {
        didSet {
            guard userData != nil else { return }
            generateResponse()
        }
    }
    
    init(storageService: FirebaseStorageServiceProtocol, type: TypeOfRecomendation) {
        self.storageService = storageService
        self.typeOfGenerationEvent = type
    }
    
    func start() {
        getUserData()
        generateResponse()
    }
    
    private func getUserData() {
        state = .loading
        storageService.getUserModel()
        storageService.userDataPublisher
            .sink { _ in
                // Add completion handling
                print("Error")
            } receiveValue: {[weak self] user in
                self?.userData = user
            }.store(in: &disposeBag)
        
        storageService.getUserMoodsData()
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
        //TODO: Remove force unwrap
        let moods = statsData.map {
            $0.classification.classifiedMood!.rawValue
        }
        
        var tokens = 450
#if DEBUG
        tokens = 150
#endif
        let daysWithoutSmoking = userData.daysWithoutSmoking
        // Please put your own token here
        let apiKey = ApiKeysService.shared.aiKey
        
        let openAi = OpenAI(apiToken: apiKey)
        let query: CompletionsQuery
        
        switch typeOfGenerationEvent {
        case .moodRecomendation:
            query = CompletionsQuery(model: .textDavinci_003, prompt: "Hello there, my name is \(name) I am a smoker and I try to quit. I don`t smoke for \(daysWithoutSmoking) days and I`m proud of it I do diary of my moods during the process and here they are \(moods) can u do an small analysis of my moods for me, provide me some help how not to start smoking again, and afer it add just something to cheer me up. Thanks", temperature: 1.0, maxTokens: tokens)

        case .timerResetRecomendation(let reasons, let metrics):
            query = CompletionsQuery(model: .textDavinci_003, prompt: "Hello there, my name is \(name) I am a smoker and I try to quit. I don`t smoke for \(daysWithoutSmoking) days and I`m proud of it I do diary of my moods during the process and here they are \(moods.joined(separator: ",")) can u do an small analysis of my moods for me, provide me some cheer words because I started smoking again, because i ve been feeling \(reasons.joined(separator: ",")). My urge to smoke was: \(metrics?.urgeToSmokeValue ?? 10) out of 10 and my mood was \(metrics?.classification.rawValue ?? "Bad") when i decided to smoke again. So the point is I dont want to this happen again add just something to cheer me up. Thanks", temperature: 1.0, maxTokens: tokens)
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
                self?.state = .loaded
                self?.recomendation = firstResponse.trimmingCharacters(in: .whitespacesAndNewlines)
            }.store(in: &disposeBag)
    }
    
    func didTapDone() {
        guard let statsData else { return }
        guard let lastMood = statsData.last?.classification else { return }
//        let type: UserHistoryRecordsType
        let record: UserHistoryModel
        switch typeOfGenerationEvent {
        case .moodRecomendation:
            record = UserHistoryModel(dateOfClassification: Date.now, selectedMoood: lastMood, selectedReasons: nil, recomendation: recomendation, typeOfHistory: .moodRecords)
        case .timerResetRecomendation(let array, _):
            record = UserHistoryModel(dateOfClassification: Date.now, selectedMoood: nil, selectedReasons: array, recomendation: recomendation, typeOfHistory: .timerResetsRecords)
        }
        
        storageService.addRecordToUserHistory(record: record)
        didSendEventClosure?(.finish)
    }
}

extension RecomendationsViewModel {
    enum EventType {
        case finish
    }
}
