//
//  ProgressChartsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import Foundation
import Combine


enum ProgressChartsState {
    case idle
    case loading
    case loaded
}
enum ProgressChartsPeriods: String {
    case oneWeek = "1 Week"
    case twoWeeks = "2 Weeks"
    case oneMonth = "1 Month"
    case threeMonth = "3 Month"
    case sixMonth = "6 Month"
    
    var valueOfPeriod: Int {
        switch self {
        case .oneWeek:
            return 7
        case .twoWeeks:
            return 14
        case .oneMonth:
            return 1
        case .threeMonth:
            return 3
        case .sixMonth:
            return 6
        }
    }
}

final class ProgressChartsViewModel: ObservableObject {
    // Divide state handling for both charts
    @Published var state: ProgressChartsState = .idle
    private var cancellables = Set<AnyCancellable>()
    private var chartModelData: [ChartModel] = [] {
        didSet {
            self.dataForCharts = chartModelData
            filterChartsData(for: selectedSotringMethod)
            filterChartsData(for: .oneWeek)
        }
    }
    
    @Published var selectedSotringMethod: ProgressChartsPeriods = .twoWeeks {
        didSet {
            filterChartsData(for: selectedSotringMethod)
        }
    }
    
    
    @Published private (set) var dataForCharts: [ChartModel] = [] {
        didSet {
            getStatistics()
            state = .loaded
        }
    }
    
    @Published var weekDataForCharts: [ChartModel] = []
    
    @Published var bestDay: String = ""
    @Published var worstDay: String = ""
    @Published var bestDayScore = ""
    @Published var worstDayScore = ""
    @Published var savedOnSigs = ""
    
    init() {
        getChartsData()
    }
    
    private lazy var currentDate: Date = {
        return Date.now
    }()
    private lazy var calendar: Calendar = {
        return Calendar.current
    }()
}

extension ProgressChartsViewModel {
    
    private func getChartsData() {
        state = .loading
        FirebaseStorageService().getChartsData()
            .sink { finish in
                print(finish)
            } receiveValue: { [weak self] data in
                self?.chartModelData = data
                    .sorted(by: {
                        $0.dateOfClassification < $1.dateOfClassification
                    })
            }.store(in: &cancellables)
    }
    
    // check for availability for longer periods
    private func filterChartsData(for period: ProgressChartsPeriods) {
        switch period {
        case .oneMonth:
            dataForCharts = filterForMonths(months: period.valueOfPeriod)
        case .threeMonth, .sixMonth:
            dataForCharts = filterForMonths(months: period.valueOfPeriod).enumerated().filter{
                $0.offset % 2 == 1
            }
            .map {
                $0.element
            }
        case .twoWeeks:
            dataForCharts = filterForWeeks(days: period.valueOfPeriod)
        case .oneWeek:
            weekDataForCharts = filterForWeeks(days: period.valueOfPeriod)
        }
    }
    
    private func filterForWeeks(days: Int) -> [ChartModel] {
        //    private let oneWeekAgo = calendar.date(byAdding: .weekday, value: -7, to: currentDate)!
        let period = calendar.date(byAdding: .weekday, value: -days,to: currentDate)!
        return chartModelData.filter({
            $0.dateOfClassification > period && $0.dateOfClassification < currentDate
        })
    }
    
    private func filterForMonths(months: Int) -> [ChartModel] {
        let period = calendar.date(byAdding: .month, value: -months, to: currentDate)!
        return chartModelData.filter {
            $0.dateOfClassification > period && $0.dateOfClassification < currentDate
        }
    }
    
    private func getStatistics() {
        let maxScoreDay = dataForCharts.max(by: {
            $0.scoreForUser < $1.scoreForUser
        })
        let minScoreDay = dataForCharts.min {
            $0.scoreForUser < $1.scoreForUser
        }
        guard let maxScoreDay = maxScoreDay, let minScoreDay = minScoreDay else { bestDay = "No data"; worstDay = "No data"; return }
        
        bestDay = maxScoreDay.dateOfClassification.toDateComponents(neededComponents: [.year, .month, .day]).toSting()
        worstDay = minScoreDay.dateOfClassification.toDateComponents(neededComponents: [.year, .month, .day]).toSting()
        
        bestDayScore = "\(maxScoreDay.scoreForUser)"
        worstDayScore = "\(minScoreDay.scoreForUser)"
        
        print("latest day of classifications \(String(describing: dataForCharts.last?.dateOfClassification))")
    }
}
