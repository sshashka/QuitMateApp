//
//  ProgressChartsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import Foundation
import Combine

enum ProgressChartsPeriods: String {
    case oneWeek = "1 Week"
    case oneMonth = "1 Month"
    case threeMonth = "3 Month"
    case sixMonth = "6 Month"
}

final class ProgressChartsViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    private var chartModelData: [ChartModel] = [] {
        didSet {
            self.dataForCharts = chartModelData
            filterChartsData(for: selectedSotringMethod)
        }
    }
    
    @Published var selectedSotringMethod: ProgressChartsPeriods = .oneMonth {
        didSet {
            filterChartsData(for: selectedSotringMethod)
        }
    }
    
    
    @Published var dataForCharts: [ChartModel] = [] {
        didSet {
            getStatistics()
    
        }
    }
    
    @Published var bestDay: String = ""
    @Published var worstDay: String = ""
    @Published var bestDayScore = ""
    @Published var worstDayScore = ""
    @Published var savedOnSigs = ""
    
    init() {
        getChartsData()
        
    }
}

extension ProgressChartsViewModel {
    private func getChartsData() {
        FirebaseStorageService().getChartsData()
            .sink { finish in
                print(finish)
            } receiveValue: { data in
                self.chartModelData = data
                    .sorted(by: {
                        $0.dateOfClassification < $1.dateOfClassification
                    })
            }.store(in: &cancellables)
    }
    
    
    private func filterChartsData(for period: ProgressChartsPeriods) {
        let currentDate = Date.now
        let calendar = Calendar.current
        let oneWeekAgo = calendar.date(byAdding: .weekday, value: -7, to: currentDate)!
        let oneMonthAgo = calendar.date(byAdding: .month, value: -1, to: currentDate)!
        let threeMonthAgo = calendar.date(byAdding: .month, value: -3, to: currentDate)!
        let sixMonthAgo = calendar.date(byAdding: .month, value: -6, to: currentDate)!
        switch period {
        case .oneMonth:
            dataForCharts = chartModelData.filter {
                $0.dateOfClassification > oneMonthAgo && $0.dateOfClassification < currentDate
            }
        case .threeMonth:
            dataForCharts = chartModelData.filter {
                $0.dateOfClassification > threeMonthAgo && $0.dateOfClassification < currentDate
            }
        case .sixMonth:
            dataForCharts = chartModelData.filter {
                $0.dateOfClassification > sixMonthAgo && $0.dateOfClassification < currentDate
            }
        case .oneWeek:
            dataForCharts = chartModelData.filter({
                $0.dateOfClassification > oneWeekAgo && $0.dateOfClassification < currentDate
            })
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
    }
}
