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
    case isShowingError
}
//MARK: - Protocol
protocol RecomendationsViewModelProtocol: AnyObject, ObservableObject {
    var state: RecomendationsViewModelState { get }
    var isShowingAlert: Bool { get set }
    var recomendation: String { get }
    var doneAndRegenerateButtonsEnabled: Bool { get set }
    func didTapDone()
    func generateResponse() async
    func start()
}
//MARK: - Protocol implementation
final class RecomendationsViewModel: RecomendationsViewModelProtocol, ViewModelBaseProtocol {
    enum TypeOfRecomendation {
        case moodRecomendation
        case timerResetRecomendation([ReasonsToStop], UserSmokingSessionMetrics)
    }
    //MARK: - Properties
    var didSendEventClosure: ((RecomendationsViewModel.EventType) -> Void)?
    private var typeOfGenerationEvent: TypeOfRecomendation
    private var disposeBag: Set<AnyCancellable> = Set<AnyCancellable>()
    private let storageService: FirebaseStorageServiceProtocol
    //MARK: - Published properties
    @Published var recomendation: String = ""
    @Published var doneAndRegenerateButtonsEnabled: Bool = false
    @Published var isShowingAlert: Bool = false
    
    @Published var state: RecomendationsViewModelState = .loading {
        didSet {
            guard state == .loaded else { doneAndRegenerateButtonsEnabled = false; return }
            doneAndRegenerateButtonsEnabled = true
        }
    }
    
    private var userData: User? {
        didSet {
            guard statsData != nil else { return }
            Task {
                await generateResponse()
            }
        }
    }
    
    private var statsData: [UserMoodModel]? {
        didSet {
            guard userData != nil else { return }
            Task {
                await generateResponse()
            }
        }
    }
    //MARK: init
    init(storageService: FirebaseStorageServiceProtocol, type: TypeOfRecomendation) {
        self.storageService = storageService
        self.typeOfGenerationEvent = type
    }
    
    func start() {
        getUserData()
        Task {
            await generateResponse()
        }
    }
   
    //MARK: - Public methods
    @MainActor
    func generateResponse() async {
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
#if DEBUG
        tokens = 150
#endif
        // Please put your own token here for debug
        let apiKey = ApiKeysService.shared.aiKey
        
        let openAi = OpenAI(apiToken: apiKey)
        let query: ChatQuery
        
        switch typeOfGenerationEvent {
        case .moodRecomendation:
            query = ChatQuery(
                messages: [.init(
                    role: .user,
                    content: [.init(
                        chatCompletionContentPartTextParam: .init(
                            text: RecomendationPrompts.getRecomendationForMoodAdded(
                                userData: userData,
                                userStats: statsData
                            )
                        )
                    )]
                )!],
                model: .gpt3_5Turbo
            )
//            query = ChatQuery(messages: [.init(role: .user, content: RecomendationPrompts.getRecomendationForMoodAdded(userData: userData, userStats: statsData)) ?? ""], model: .gpt3_5Turbo, maxTokens: tokens)
        case .timerResetRecomendation(let reasons, let metrics):
            query = ChatQuery(
                messages: [.init(
                    role: .user,
                    content: [.init(
                        chatCompletionContentPartTextParam: .init(
                            text:  RecomendationPrompts.getPromtForSmokingSession(
                                userData: userData,
                                userStats: statsData,
                                reasons: reasons,
                                metrics: metrics
                            )
                        )
                    )]
                )!],
                model: .gpt3_5Turbo
            )
        }
        do {
            let result = try await openAi.chats(query: query)
            recomendation = result.choices.first?.message.content?.string ?? String()
            state = .loaded
        } catch {
            state = .isShowingError
            isShowingAlert = true
        }
        
//        openAi.chatsStream(query: query)
//            .receive(on: RunLoop.main)
//            .sink {
//                print($0)
//            } receiveValue: { [weak self] result in
//                switch result {
//                case .success(let responce):
//                    self?.state = .loaded
//                    var text = String()
//                    text = responce.choices.first?.delta.content ?? String()
//                    self?.recomendation += text
//                case .failure(_):
//                    break
//                }
//            }.store(in: &disposeBag)
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

//MARK: - Private methods
private extension RecomendationsViewModel {
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
