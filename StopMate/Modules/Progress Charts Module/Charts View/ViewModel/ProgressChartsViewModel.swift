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

protocol ProgressChartsViewModelProtocol: AnyObject, ObservableObject {
    var state: ProgressChartsState { get }
    var selectedSotringMethod: ProgressChartsPeriods { get set }
    var filteredDataForCharts: [ChartModel] { get }
    var weekDataForCharts: [ChartModel] { get }
    var alertText: String { get }
    var isShowingAlert: Bool { get set }
    var isDetailedChartsEnabled: Bool { get }
    func didTapOnAddingMood()
    func getDetailedInfoViewModel() -> DetailedChartsViewModel
}

final class ProgressChartsViewModel: ProgressChartsViewModelProtocol {
    @Published var state: ProgressChartsState = .idle
    private let storageService: FirebaseStorageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    var didSendEventClosure: ((ProgressChartsViewModel.EventTypes) -> Void)?
    @Published private var chartModelData: [ChartModel] = [] {
        didSet {
            self.filteredDataForCharts = chartModelData
            filterChartsData(for: selectedSotringMethod)
            filterChartsData(for: .oneWeek)
        }
    }
    
    @Published var selectedSotringMethod: ProgressChartsPeriods = .twoWeeks {
        didSet {
            filterChartsData(for: selectedSotringMethod)
        }
    }
    
    
    @Published private (set) var filteredDataForCharts: [ChartModel] = [] {
        didSet {
            state = .loaded
        }
    }
    
    @Published var weekDataForCharts: [ChartModel] = []
    @Published var alertText = ""
    @Published var isShowingAlert: Bool = false
    @Published var isDetailedChartsEnabled: Bool = false
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        isDetailedChartsViewAvalible.assign(to: &$isDetailedChartsEnabled)
        start()
    }
    
    private lazy var currentDate: Date = {
        return Date.now
    }()
    private lazy var calendar: Calendar = {
        return Calendar.current
    }()
    
    private func start() {
        getChartsData()
    }
    
    func getDetailedInfoViewModel() -> DetailedChartsViewModel {
        return DetailedChartsViewModel(data: chartModelData)
    }
    
    func didTapOnAddingMood() {
        guard canAddNewMood else {
            alertText = "You have already marked your mood today. So, come back tomorrow."
            isShowingAlert.toggle()
            return
        }
        didSendEventClosure?(.newMood)
    }
}

private extension ProgressChartsViewModel {
    var isDetailedChartsViewAvalible: AnyPublisher<Bool, Never> {
        $chartModelData
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var canAddNewMood: Bool {
        let dates = chartModelData.map {
            $0.dateOfClassificationByDate
        }
        return Date.checkIfArrayContainsToday(array: dates)
    }
    
    func getChartsData() {
        state = .loading
        storageService.getChartsData()
            .sink { finish in
                print(finish)
            } receiveValue: { [weak self] data in
                self?.chartModelData = data
                    .sorted(by: {
                        $0.dateOfClassification < $1.dateOfClassification
                    })
            }.store(in: &cancellables)
    }
    
    //TODO: check for availability for longer periods
    func filterChartsData(for period: ProgressChartsPeriods) {
        switch period {
        case .oneMonth:
            filteredDataForCharts = filterForMonths(months: period.valueOfPeriod)
        case .threeMonth, .sixMonth:
            filteredDataForCharts = filterForMonths(months: period.valueOfPeriod).enumerated().filter{
                $0.offset % 3 == 1
            }
            .map {
                $0.element
            }
        case .twoWeeks:
            filteredDataForCharts = filterForWeeks(days: period.valueOfPeriod)
        case .oneWeek:
            weekDataForCharts = filterForWeeks(days: period.valueOfPeriod)
        }
    }
    
    func filterForWeeks(days: Int) -> [ChartModel] {
        let period = calendar.date(byAdding: .weekday, value: -days,to: currentDate)!
        return chartModelData.filter({
            $0.dateOfClassification > period && $0.dateOfClassification < currentDate
        })
    }
    
    func filterForMonths(months: Int) -> [ChartModel] {
        let period = calendar.date(byAdding: .month, value: -months, to: currentDate)!
        return chartModelData.filter {
            $0.dateOfClassification > period && $0.dateOfClassification < currentDate
        }
    }
}

extension ProgressChartsViewModel {
    enum EventTypes {
        case newMood
    }
}
