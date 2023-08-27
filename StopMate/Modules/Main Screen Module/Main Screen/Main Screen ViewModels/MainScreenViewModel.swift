//
//  MainScreenViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.04.2023.
//

import Foundation
import Combine

protocol MainScreenViewModelProtocolVariables {
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
}

protocol MainScreenViewModelProtocolMethods {
    func didTapOnReset()
    func didTapOnSettings()
}

protocol MainScreenViewModelProtocol: AnyObject, ObservableObject, MainScreenViewModelProtocolVariables, MainScreenViewModelProtocolMethods  { }

enum MainScreenViewModelStates {
    case loading, loaded
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    private let storageService: FirebaseStorageServiceProtocol
    private var disposeBag = Set<AnyCancellable>()

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
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        getUserModel()
    }
    
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
}

private extension MainScreenViewModel {
    func setupPiplines() {
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
        dateFormatter.locale = NSLocale(localeIdentifier: "EN") as Locale
        todayDate = dateFormatter.string(from: date)
    }
    
    func getDateComponentsWithoutSmoking() {
        guard let userStatistics = userStatistics else { return }
        dateComponentsWithoutSmoking = userStatistics.dateInComponentsWithoutSmoking
    }
    
    func getDaysLeft() {
        guard let userStatistics = userStatistics else { return }
        daysToFinish = String(userStatistics.daysToFinish)
    }
    
    func getEmissions() {
        guard let userStatistics = userStatistics else { return }
        emissions = String(Double(userStatistics.daysWithoutSmoking) * 2.5) + "g"
    }
}

extension MainScreenViewModel {
    enum EventType {
        case didTapResetButton, didTapOnSettings
    }
}
