//
//  MainScreenViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.04.2023.
//

import Foundation
import Combine

final class MainScreenViewModel: ObservableObject {
    private let storageService: FirebaseStorageServiceProtocol
    private var disposeBag = Set<AnyCancellable>()
    //    @Published var isLoading = true
    @Published private var userStatistics: User? {
        didSet {
            setupPiplines()
        }
    }
    
    var didSendEventClosure: ((MainScreenViewModel.EventType) -> Void)?
    
    @Published var showingAdditionalInfo = false
    
    @Published var percentsToFinish: Double = 0.0
    
    @Published var daysWithoutSmoking: Int = 0
    
    @Published var percentageOfScore: Int = 0
    
    @Published var moneySaved: Double = 0.0
    
    @Published var todayDate: String = ""
    
    @Published var enviromentalChanges = 6
    
    @Published var daysToFinish = ""
    
    @Published var dateComponentsWithoutSmoking: String = ""
    
    @Published var additionalInfoViewModel: AdditionalInfoViewModel = AdditionalInfoViewModel(model: [AdditionalInfoModel]())
    
    //    @Published var confirmedReset = false {
    //        // ITs a wrong way of doing this
    //        didSet {
    //            guard confirmedReset != false else { return }
    //            didTapOnReset()
    //        }
    //    }”
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        getUserModel()
    }
    
    func getUserModel() {
        //        storageService.userPublisher
        storageService.userDataPublisher
            .sink {
                print($0)
            } receiveValue: { [weak self] stats in
                self?.userStatistics = stats
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
        setupAdditionalInfoViewModel()
    }
    
    func getDaysWithoutSmoking() {
        guard let model = userStatistics else { return }
        daysWithoutSmoking = model.daysWithoutSmoking
    }
    
    func getMoneySavedOnSigarets() {
        guard let model = userStatistics else { return }
        moneySaved = model.moneySpentOnSigarets
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
    }
    
    func setupAdditionalInfoViewModel() {
        guard let userStatistics = userStatistics else { return }
        
        let additionalInfoModels = [AdditionalInfoModel(icon: IconConstants.danger, text: "You don`t smoke for:", value: String(userStatistics.daysWithoutSmoking), bottomText: "days"), AdditionalInfoModel(icon: IconConstants.danger, text: "That is:", value: String(userStatistics.weeksWithoutSmoking), bottomText: "weeks"), AdditionalInfoModel(icon: IconConstants.danger, text: "Or", value: String(userStatistics.monthsWithoutSmoking), bottomText: "months"), AdditionalInfoModel(icon: "", text: "", value: String(userStatistics.moneySavedPerWeek), bottomText: "dollars per week"), AdditionalInfoModel(icon: "", text: "Or", value: String(userStatistics.moneySavedPerMonth), bottomText: "dollars per month"), AdditionalInfoModel(icon: IconConstants.money, text: "And" , value: String(userStatistics.moneySavedPerYear), bottomText: "dollars each year")]
        additionalInfoViewModel = AdditionalInfoViewModel(model: additionalInfoModels)
    }
}

extension MainScreenViewModel {
    enum EventType {
        case didTapResetButton, didTapOnSettings
    }
}
