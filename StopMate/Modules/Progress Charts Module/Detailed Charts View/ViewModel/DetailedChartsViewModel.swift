//
//  DetailedChartsViewModel.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.08.2023.
//

import Foundation

protocol DetailedChartsViewModelProtocol: ObservableObject {
    var moodsCountData: [DetailedChartModel] { get }
    var progressChartStats: [ProgressChartStatisticsModel] { get }
    var moodsCountText: String { get }
    var monthsDetailsText: String { get }
    var correlation: Double { get }
    func start()
}

final class DetailedChartsViewModel: DetailedChartsViewModelProtocol {
    @Published var data: [UserMoodModel]
    
    @Published var moodsCountData = [DetailedChartModel]()
    
    @Published var progressChartStats = [ProgressChartStatisticsModel]()
    
    @Published var moodsCountText: String = ""
    
    @Published var monthsDetailsText: String = ""
    
    @Published var correlation: Double
    
    init(data: [UserMoodModel], correlation: Double) {
        self.data = data
        self.correlation = correlation
    }
    
    func start() {
        moodsCountData = convertToChartData(chartModels: data)
        filterChartsByMonts()
        getMoodsDetails()
        getMonthsDetails()
    }
    
    private func getMoodsDetails() {
        let text = Localizables.DetailedCharts.chartAboveMoodsDetails
        let sortedMoodsCount = moodsCountData.sorted {$0.count > $1.count}
        let moodAndCount: [String] = sortedMoodsCount.map {
            return String (localized: "Charts.moodsCount.\($0.mood.localizedCase) \($0.count)", table: "Localizable")
        }
        let overallMoodsCount = moodsCountData.reduce(0) { $0 + $1.count }
        let overallMoodsCountText = String(localized: "Charts.overallTimes.\(overallMoodsCount)", table: "Localizable")
        moodsCountText = text + moodAndCount.joined() + overallMoodsCountText
    }
    
    private func getMonthsDetails() {
        let groupedByMonthAndYear = Dictionary(grouping: progressChartStats, by: { $0.monthAndYear })
        var maxMoodCountsByMonthAndYear: [Date: (mood: ClassifiedMood, count: Int)] = [:]
        
        for (monthAndYear, statistics) in groupedByMonthAndYear {
            // Find the mood with the maximum count for the current month and year
            if let maxStatistics = statistics.max(by: { $0.count < $1.count }) {
                maxMoodCountsByMonthAndYear[monthAndYear] = (mood: maxStatistics.mood, count: maxStatistics.count)
            }
        }
        var messageToUser = Localizables.DetailedCharts.monthlyChartExplanation
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        // Sort the dictionary by keys (dates)
        let sortedMaxMoodCounts = maxMoodCountsByMonthAndYear.sorted { $0.key < $1.key }

        for (monthAndYear, maxMoodCount) in sortedMaxMoodCounts {
            let formattedMonthAndYear = dateFormatter.string(from: monthAndYear).capitalized
            let mood = maxMoodCount.mood.localizedCase
            let count = maxMoodCount.count
            let message = String(localized: "Charts.monthMoodCount.\(formattedMonthAndYear)\(mood)\(count)", table: "Localizable")
            messageToUser += message
        }
        monthsDetailsText = messageToUser
    }
        
    
    private func convertToChartData(chartModels: [UserMoodModel]) -> [DetailedChartModel] {
        // Create an empty dictionary to store mood classifications and their counts and dates
        var moodDetails: [ClassifiedMood: (count: Int, dates: [Date])] = [:]

        // Count the occurrences of each mood classification and collect their dates
        for chartModel in chartModels {
            var (count, dates) = moodDetails[chartModel.classification, default: (0, [])]
            count += 1
            dates.append(chartModel.dateOfClassification)
            moodDetails[chartModel.classification] = (count: count, dates: dates)
        }

        // Create an array of DetailedChartModel instances from the moodDetails dictionary
        let detailedChartModels = moodDetails.map { mood, details in
            DetailedChartModel(mood: mood, count: details.count, datesOfClassifications: details.dates)
        }

        return detailedChartModels
    }
    
    private func filterChartsByMonts() {

        // Step 1: Group ChartModel instances by month and year
        let groupedByMonthAndYear = Dictionary(grouping: data) { (model) -> Date in
            return model.dateOfClassificationMonthAndYear
        }

        // Step 2: Convert the grouped data into an array of MonthsMoodStatisticsModel
        var monthsMoodStatistics: [ProgressChartStatisticsModel] = []
        for (_, models) in groupedByMonthAndYear {
            // Step 3: Calculate the count for each mood within the group
            var moodCounts: [ClassifiedMood: Int] = [:]
            for model in models {
                let mood = model.classification
                moodCounts[mood] = (moodCounts[mood] ?? 0) + 1
            }

            // Step 4: Create the MonthsMoodStatisticsModel instance and add it to the array
            if let firstModel = models.first {
                let monthAndYear = firstModel.dateOfClassificationMonthAndYear
                for (mood, count) in moodCounts {
                    let statisticsModel = ProgressChartStatisticsModel(monthAndYear: monthAndYear, mood: mood, count: count)
                    monthsMoodStatistics.append(statisticsModel)
                }
            }
        }
        progressChartStats = monthsMoodStatistics
    }
}
