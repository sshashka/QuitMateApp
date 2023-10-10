//
//  ProgressChartsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import Foundation
import Combine
import SigmaSwiftStatistics

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
    
    var localizedCase: String {
        switch self {
        case .oneWeek:
            return String(localized: "Shared.week.\(1)")
        case .twoWeeks:
            return String(localized: "Shared.week.\(2)")
        case .oneMonth, .threeMonth, .sixMonth:
            return String(localized: "Shared.month.\(self.valueOfPeriod)")
        }
    }
}

protocol ProgressChartsViewModelProtocol: AnyObject, ObservableObject {
    var state: ProgressChartsState { get }
    var weeklyChartData: [ChartModel] { get }
    var chartData: [ChartModel] { get }
    var selectedSotringMethod: ProgressChartsPeriods { get set }
    var alertText: String { get }
    var isShowingAlert: Bool { get set }
    var isDetailedChartsEnabled: Bool { get }
    var weeklyChartYDomain: ClosedRange<Int> { get }
    var chartYDomain: ClosedRange<Int> { get }
    func didTapOnAddingMood()
    func getDetailedInfoViewModel() -> DetailedChartsViewModel
}

final class ProgressChartsViewModel: ProgressChartsViewModelProtocol {
    private let storageService: FirebaseStorageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    var didSendEventClosure: ((ProgressChartsViewModel.EventTypes) -> Void)?
    
    private lazy var currentDate: Date = {
        return Date.now
    }()
    private lazy var calendar: Calendar = {
        return Calendar.current
    }()
    
    @Published var alertText = ""
    @Published var isShowingAlert: Bool = false
    @Published var isDetailedChartsEnabled: Bool = false
    
    var weeklyChartYDomain: ClosedRange<Int> = 0...0
    @Published var chartYDomain: ClosedRange<Int> = 0...0
    
    @Published var state: ProgressChartsState = .idle
    @Published var userMoodRecords: [UserMoodModel] = [] {
        didSet {
            guard !userSmokingRecords.isEmpty else { return }
            chartData = getChartsData(for: selectedSotringMethod)
            weeklyChartData = getChartsData(for: .oneWeek)
        }
    }
    
    @Published private(set) var weeklyChartData: [ChartModel] = [] {
        didSet {
            weeklyChartYDomain = getChartDomain(for: .oneWeek)
        }
    }
    @Published private(set) var userSmokingRecords: [UserSmokingSessionMetrics] = [] {
        didSet {
            guard !userMoodRecords.isEmpty else { return }
            chartData = getChartsData(for: selectedSotringMethod)
            weeklyChartData = getChartsData(for: .oneWeek)
        }
    }
    
    @Published private(set) var chartData: [ChartModel] = [] {
        didSet {
            chartYDomain = getChartDomain(for: selectedSotringMethod)
            state = .loaded
        }
    }
    
    @Published var selectedSotringMethod: ProgressChartsPeriods = .twoWeeks {
        didSet {
            chartData = getChartsData(for: selectedSotringMethod)
        }
    }
    
    init(storageService: FirebaseStorageServiceProtocol) {
        self.storageService = storageService
        isDetailedChartsViewAvalible.assign(to: &$isDetailedChartsEnabled)
        start()
    }
    
    private func start() {
        getUserMoodsData()
        getUserSmokingSessionMetrics()
    }
    
    func getDetailedInfoViewModel() -> DetailedChartsViewModel {
        return DetailedChartsViewModel(data: userMoodRecords, correlation: calculateCorrelation())
    }
    
    func didTapOnAddingMood() {
        guard canAddNewMood else {
            alertText = Localizables.ChartsStrings.moodAlreadyMarkedToday
            isShowingAlert.toggle()
            return
        }
        didSendEventClosure?(.newMood)
    }
}

private extension ProgressChartsViewModel {
    var isDetailedChartsViewAvalible: AnyPublisher<Bool, Never> {
        $userMoodRecords
            .map { !$0.isEmpty }
            .eraseToAnyPublisher()
    }
    
    private var canAddNewMood: Bool {
        let dates = userMoodRecords.map {
            $0.dateOfClassification
        }
        return Date.checkIfArrayContainsToday(array: dates)
    }
    // MARK: Downloading data
    func getUserMoodsData() {
        state = .loading
        storageService.getUserMoodsData()
            .sink { finish in
                print(finish)
            } receiveValue: { [weak self] data in
                self?.userMoodRecords = data
            }.store(in: &cancellables)
    }
    
    func getUserSmokingSessionMetrics() {
        storageService.getUserSmokingSessionMetrics()
        storageService.userSmokingSessionMetricsSubject
            .receive(on: RunLoop.main)
            .sink { error in
                print(error)
            } receiveValue: { [weak self] result in
                guard let result = result else { return }
                self?.userSmokingRecords = result.sorted(by: {
                    $0.dateOfClassification < $1.dateOfClassification
                })
            }
            .store(in: &cancellables)
    }
    
    func getChartsData(for period: ProgressChartsPeriods) -> [ChartModel] {
        let userMoods = filterChartsData(for: period).userMoodRecords.map { mood in
            ChartModel(id: UUID(), type: .moods, mood: mood.classification, date: mood.dateOfClassification)
        }
        
        let smokingSessions = filterChartsData(for: period).userSmokingSessions.map {
            ChartModel(id: UUID(), type: .smoking, mood: $0.classification, date: $0.dateOfClassification)
        }
        
        let data = userMoods + smokingSessions
        return data
    }
    // MARK: Filtering userMoods
    //TODO: check for availability for longer periods
    func filterChartsData(for period: ProgressChartsPeriods) -> (userMoodRecords: [UserMoodModel], userSmokingSessions: [UserSmokingSessionMetrics]) {
        var userMoodsFiltered: [UserMoodModel] = []
        var smokingSessionsFiltered: [UserSmokingSessionMetrics] = []
        switch period {
        case .oneMonth:
            userMoodsFiltered = filterForMonths(data: userMoodRecords, months: period.valueOfPeriod)
            smokingSessionsFiltered = filterForMonths(data: userSmokingRecords, months: period.valueOfPeriod)
            break
        case .threeMonth, .sixMonth:
            userMoodsFiltered = filterForMonths(data: userMoodRecords, months: period.valueOfPeriod)
            smokingSessionsFiltered = filterForMonths(data: userSmokingRecords, months: period.valueOfPeriod)
        case .twoWeeks:
            userMoodsFiltered = filterForWeeks(data: userMoodRecords, days: period.valueOfPeriod)
            smokingSessionsFiltered = filterForWeeks(data: userSmokingRecords, days: period.valueOfPeriod)
        case .oneWeek:
            userMoodsFiltered = filterForWeeks(data: userMoodRecords, days: period.valueOfPeriod)
            smokingSessionsFiltered = filterForWeeks(data: userSmokingRecords, days: period.valueOfPeriod)
        }
        
        return (userMoodsFiltered, smokingSessionsFiltered)
    }
    
    func filterForWeeks<T: ChartDataFilteringProtocol>(data: [T], days: Int) -> [T] {
        let period = calendar.date(byAdding: .weekday, value: -days,to: currentDate)!
        let data = data
        return data.filter({
            $0.dateOfClassification > period && $0.dateOfClassification < currentDate
        })
    }
    
    func filterForMonths<T: ChartDataFilteringProtocol>(data: [T], months: Int) -> [T] {
        let period = calendar.date(byAdding: .month, value: -months, to: currentDate)!
        let filteredData = data.filter {
            $0.dateOfClassification > period && $0.dateOfClassification < currentDate
        }
        if filteredData.count > 5 {
            return filteredData.enumerated().filter {
                $0.offset % 3 == 1
            }
            .map {
                $0.element
            }
        }
        return filteredData
    }
    
    // MARK: Getting domain for Y-axis of charts
    func getChartDomain(for period: ProgressChartsPeriods) -> ClosedRange<Int> {
        var moodsArr: [Int] = []
        switch period {
        case .oneWeek:
            moodsArr = weeklyChartData.map {
                $0.mood.moodNumber
            }
        default:
            moodsArr = chartData.map {
                $0.mood.moodNumber
            }
        }
        if let lowerBound = moodsArr.min(), let upperBound = moodsArr.max() {
            let range = lowerBound...upperBound
            return range
        }
        return 0...ClassifiedMood.allCases.count
    }
    
    func calculateCorrelation() -> Double {
        // This one needs to be a Set so I don`t add a new value each time smoking session with corresponding date found
        var moodsArr = Set<UserMoodModel>()
        var smokingArr = [UserSmokingSessionMetrics]()
        
        // TODO: Remake it smarter way
        // Finding records made on the same day in two arrays
        for smokingRecord in userSmokingRecords {
            for moodRecord in userMoodRecords {
                if smokingRecord.dateOfClassification.toDateComponents(neededComponents: [.year, .month, .day]) == moodRecord.dateOfClassification.toDateComponents(neededComponents: [.year, .month, .day]) {
                    moodsArr.insert(moodRecord)
                    smokingArr.append(smokingRecord)
                }
            }
        }
        
        let moodArrValues = moodsArr.sorted{ $0.dateOfClassification < $1.dateOfClassification }.map {
            Double($0.classification.moodNumber)
        }
        
        let groupedValues = Dictionary(grouping: smokingArr, by: { $0.dateOfClassificationMonthAndYear })
        let sortedGroupedValues = groupedValues.sorted { $0.key < $1.key }
        
        var meanMoodValues: [Double] = []
        
        for (_, values) in sortedGroupedValues {
            if values.count > 1 {
                let totalValue = values.reduce(0.0) { $0 + Double($1.classification.moodNumber) }
                let meanValue = totalValue / Double(values.count)
                meanMoodValues.append(meanValue)
            } else {
                meanMoodValues.append(Double(values.first!.classification.moodNumber))
            }
        }
        
        let result = Sigma.pearson(x: moodArrValues, y: meanMoodValues)
        guard let result else { return -1.0 }
        return result
    }
}

extension ProgressChartsViewModel {
    enum EventTypes {
        case newMood
    }
}
