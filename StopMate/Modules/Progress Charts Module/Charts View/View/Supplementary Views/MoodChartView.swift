//
//  MoodChartView.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.03.2023.
//

import SwiftUI
import Charts

struct MoodChartView: View {
    var dataForCharts: [ChartModel]
    var domain: ClosedRange<Int>
    @State var state: ProgressChartsState
    
    var body: some View {
        if dataForCharts.isEmpty {
            VStack(alignment: .center) {
                Text(Localizables.noData)
                    .fontStyle(.header)
            }
        } else {
            Chart(dataForCharts) { chart in
                PointMark(x: .value("Day", chart.date), y: .value("Mood", chart.mood.moodNumber))
                    .interpolationMethod(.linear)
                    .foregroundStyle(by: .value("Type", chart.type))
                
                LineMark(x: .value("Day", chart.date), y: .value("Mood", chart.mood.moodNumber))
                    .interpolationMethod(.linear)
                    .foregroundStyle(by: .value("Type", chart.type))
            }
            .chartYAxis {
                AxisMarks(preset: .automatic, position: .leading, values: .stride(by: 1)) {
                    if let number = $0.as(Int.self) {
                        AxisValueLabel {
                            if let mood = ClassifiedMood(moodNumber: number) {
                                VStack(alignment: .leading) {
                                    Text(mood.rawValue)
                                }
                            }
                        }
                    }
                    AxisGridLine()
                    AxisTick()
                }
            }
            .chartForegroundStyleScale([
                "Smoking sessions": .purple, "Marked moods": .mint
            ])
            .chartXScale(range: .plotDimension(padding: Spacings.spacing20))
            .chartYScale(domain: domain)
            .animation(.easeInOut(duration: 0.7), value: dataForCharts)
        }
        
    }
}
//
struct MoodChartView_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = [ChartModel]()
        MoodChartView(dataForCharts: mockData, domain: 0...6, state: .loaded)
    }
}
