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
//MARK: - Protocol
protocol RecomendationsViewModelProtocol: AnyObject, ObservableObject {
    var state: RecomendationsViewModelState { get }
    var recomendation: String { get }
    var doneAndRegenerateButtonsEnabled: Bool { get set }
    func didTapDone()
    func generateResponse()
    func start()
}
//MARK: - Protocol implementation
final class RecomendationsViewModel: RecomendationsViewModelProtocol {
    enum TypeOfRecomendation {
        case moodRecomendation
        case timerResetRecomendation([String], UserSmokingSessionMetrics)
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
    //MARK: init
    init(storageService: FirebaseStorageServiceProtocol, type: TypeOfRecomendation) {
        self.storageService = storageService
        self.typeOfGenerationEvent = type
    }
    
    func start() {
        getUserData()
        generateResponse()
    }
   
    //MARK: - Public methods
    func generateResponse() {
        state = .loading
        guard let userData = userData else { return }
        guard let statsData = statsData else { return }
        
        var tokens = 0
        //AI model requires more tokens for cyrilyc languages
        let locale = Locale.current
        guard locale.language.languageCode == "uk" else {
            tokens = 450
            return
        }
        tokens = 700
        
//#if DEBUG
//        tokens = 150
//#endif
        let daysWithoutSmoking = userData.daysWithoutSmoking
        // Please put your own token here for debug
        let apiKey = ApiKeysService.shared.aiKey
        
        let openAi = OpenAI(apiToken: apiKey)
        let query: CompletionsQuery
        
        switch typeOfGenerationEvent {
        case .moodRecomendation:
            query = CompletionsQuery(model: .textDavinci_003, prompt: RecomendationPrompts.getRecomendationForMoodAdded(userData: userData, userStats: statsData), temperature: 1.0, maxTokens: tokens)

        case .timerResetRecomendation(let reasons, let metrics):
            query = CompletionsQuery(model: .textDavinci_003, prompt: RecomendationPrompts.getPromtForSmokingSession(userData: userData, userStats: statsData, reasons: reasons, metrics: metrics), temperature: 1.0, maxTokens: tokens)
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
    
    //MARK: Saving responce
    func didTapDone() {
        guard let statsData else { return }
        guard let lastMood = statsData.last?.classification else { return }
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

private extension RecomendationsViewModel {
    //MARK: - Private methods
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
}

extension RecomendationsViewModel {
    enum EventType {
        case finish
    }
}
