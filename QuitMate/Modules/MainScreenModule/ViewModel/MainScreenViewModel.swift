//
//  MainScreenViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 26.04.2023.
//

import Foundation
import Combine

class MainScreenViewModel: ObservableObject {
    private var disposeBag = Set<AnyCancellable>()
    private let currentDate = Date()
    @Published private var userStatistics: UserStatisticsModel? {
        didSet {
            setupPiplines()
        }
    }
    
    @Published var percentsToFinish: Float = 0.0
    
    @Published var daysWithoutSmoking: Int = 0
    
    @Published var percentageOfScore: Int = 0
    
    @Published var moneySaved: Double = 0.0
    
    @Published var todayDate: String = ""
    
    @Published var enviromentalChanges = 6
    
    @Published var dateComponentsWithoutSmoking: String = ""
    
    init() {
        getUserModel()
    }
    
    func getUserModel() {
        FirebaseStorageService().getUserStatistics()
            .sink {
                print($0)
            } receiveValue: { stats in
                self.userStatistics = stats.first
            }.store(in: &disposeBag)
    }
    
    
}

private extension MainScreenViewModel {
    func setupPiplines() {
        getMoneySavedOnSigarets()
        getPercentsToFinish()
        getTodayDate()
        getDaysWithoutSmoking()
        getDateComponentsWithoutSmoking()
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
}
