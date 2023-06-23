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
    @Published private var userStatistics: User? {
        didSet {
            setupPiplines()
            print(userStatistics)
        }
    }
    
    var didSendEventClosure: ((MainScreenViewModel.EventType) -> Void)?
    
    @Published var percentsToFinish: Float = 0.0
    
    @Published var daysWithoutSmoking: Int = 0
    
    @Published var percentageOfScore: Int = 0
    
    @Published var moneySaved: Double = 0.0
    
    @Published var todayDate: String = ""
    
    @Published var enviromentalChanges = 6
    
    @Published var daysToFinish = ""
    
    @Published var dateComponentsWithoutSmoking: String = ""
    
    @Published var confirmedReset = false {
        // ITs a wrong way of doing this
        didSet {
            guard confirmedReset != false else { return }
            didTapOnReset()
        }
    }
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        getUserModel()
    }
    
    func getUserModel() {
        storageService.getUserStatistics()
            .sink {
                print($0)
            } receiveValue: { stats in
                self.userStatistics = stats.first
            }.store(in: &disposeBag)
    }
    // Rename this func
    func didTapOnReset() {
        self.didSendEventClosure?(.didTapResetButton)
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
        print(daysToFinish + "DAYS LEFT")
    }
}

extension MainScreenViewModel {
    enum EventType {
        case didTapResetButton
    }
}
