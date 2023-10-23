//
//  MainScreenViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.04.2023.
//

import Foundation
import Combine

enum AdditionalStatsTypes {
    case money, enviroment
}
// MARK: - Protocol
protocol MainScreenViewModelProtocolVariables: ObservableObject {
    var state: MainScreenViewModelStates { get }
    var showingAdditionalInfo: Bool { get set }
    var percentsToFinish: Double { get }
    var daysWithoutSmoking: String { get }
    var moneySaved: String { get }
    var todayDate: String { get }
    var enviromentalChanges: String { get }
    var daysToFinish: String { get }
    var dateComponentsWithoutSmoking: String { get }
    var emissions: String { get }
    var isPresentingSheet: Bool { get set }
    var additionalInfoViewModel: AdditionalInfoViewModel? { get }
}

protocol MainScreenViewModelProtocolMethods {
    func didTapOnReset()
    func didTapOnSettings()
    func didTapOnAdditionalStats(type: AdditionalStatsTypes)
}

protocol MainScreenViewModelProtocol: AnyObject, ObservableObject, MainScreenViewModelProtocolVariables, MainScreenViewModelProtocolMethods  { }

enum MainScreenViewModelStates {
    case loading, loaded
}


final class MainScreenViewModel: MainScreenViewModelProtocol {
    private let storageService: FirebaseStorageServiceProtocol
    private var disposeBag = Set<AnyCancellable>()
    // MARK: - Published properties
    @Published private var userStatistics: User? {
        didSet {
            setupPiplines()
        }
    }
    
    
    var didSendEventClosure: ((MainScreenViewModel.EventType) -> Void)?
    
    @Published var state: MainScreenViewModelStates = .loading
    
    @Published var showingAdditionalInfo = false
    
    @Published var percentsToFinish: Double = 0.0
    
    @Published var daysWithoutSmoking: String = ""
    
    @Published var moneySaved: String = ""
    
    @Published var todayDate: String = ""
    
    @Published var enviromentalChanges = ""
    
    @Published var daysToFinish = ""
    
    @Published var dateComponentsWithoutSmoking: String = ""
    
    @Published var emissions: String = ""
    
    @Published var isPresentingSheet: Bool = false
    
    @Published var additionalInfoViewModel: AdditionalInfoViewModel?
    // MARK: - init
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        getUserModel()
    }
    // MARK: - Public methods
    private func getUserModel() {
        storageService.userDataPublisher
            .sink {
                print($0)
            } receiveValue: { [weak self] stats in
                self?.userStatistics = stats
                self?.state = .loaded
            }.store(in: &disposeBag)
    }
    // Rename this func
    func didTapOnReset() {
        self.didSendEventClosure?(.didTapResetButton)
    }
    
    func didTapOnSettings() {
        didSendEventClosure?(.didTapOnSettings)
    }
    
    func didTapOnAdditionalStats(type: AdditionalStatsTypes) {
        guard let userStatistics else { return }
        switch type {
        case .money:
            additionalInfoViewModel = AdditionalInfoViewModel(value: AdditionalInfoModel(value: userStatistics.moneyUserSpendsOnSmoking, valueType: .daily, valueUnit: .money(userStatistics.userCurrency?.rawValue ?? "$")), headerText: Localizables.MainScreen.additionalScreenSavingsHeader, explanatoryText: Localizables.MainScreen.additionalScreenSavingsExplanatory)
        case .enviroment:
            additionalInfoViewModel = AdditionalInfoViewModel(value: AdditionalInfoModel(value: 2.5, valueType: .daily, valueUnit: .emissions("g")), headerText: Localizables.MainScreen.additionalScreenPollutions, explanatoryText: Localizables.MainScreen.additionalScreenPollutionsExplanatory)
        }
        isPresentingSheet = true
    }
    
}
// MARK: - Private methods
private extension MainScreenViewModel {
    func setupPiplines() {
        guard let userStatistics else {
            return
        }
        if userStatistics.milestoneCompleted {
            didSendEventClosure?(.milestoneCompleted)
        }
        getMoneySavedOnSigarets()
        getPercentsToFinish()
        getTodayDate()
        getDaysWithoutSmoking()
        getDateComponentsWithoutSmoking()
        getDaysLeft()
        getEmissions()
    }
    
    func getDaysWithoutSmoking() {
        guard let model = userStatistics else { return }
        daysWithoutSmoking = String(model.daysWithoutSmoking)
    }
    
    func getMoneySavedOnSigarets() {
        guard let model = userStatistics else { return }
        let moneyValue = model.moneySpentOnSigarets
        guard let moneyCurrency = model.userCurrency?.rawValue else { return }
        moneySaved = String(moneyValue.rounded()) + String(moneyCurrency)
    }
    
    func getPercentsToFinish() {
        guard let model = userStatistics else { return }
        let percents = model.completionPercents
        guard percents.isFinite else {
            percentsToFinish = 1
            return
        }
        percentsToFinish = model.completionPercents
    }
    
    func getTodayDate() {
        let date = Date.now
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        todayDate = dateFormatter.string(from: date)
    }
    
    func getDateComponentsWithoutSmoking() {
        guard let userStatistics = userStatistics else { return }
        dateComponentsWithoutSmoking = userStatistics.dateInComponentsWithoutSmoking
    }
    
    func getDaysLeft() {
        guard let userStatistics = userStatistics else { return }
        daysToFinish = String(userStatistics.daysToFinish)
        print(userStatistics.finishingDate)
    }
    
    func getEmissions() {
        guard let userStatistics = userStatistics else { return }
        emissions = String(Double(userStatistics.daysWithoutSmoking) * 2.5) + "g"
    }
}
// MARK: - Events for coordinator
extension MainScreenViewModel {
    enum EventType {
        case didTapResetButton, didTapOnSettings, milestoneCompleted
    }
}
