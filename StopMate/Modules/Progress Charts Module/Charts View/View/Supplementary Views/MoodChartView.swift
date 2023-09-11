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
    @State var state: ProgressChartsState
    
    var body: some View {
        if dataForCharts.count == 0 {
            VStack(alignment: .center) {
                Text("No data, yet")
                    .fontStyle(.header)
            }
        } else {
            Chart(dataForCharts) { chart in
                LineMark(x: .value("Day", chart.date), y: .value("Mood", chart.mood.rawValue))
                    .interpolationMethod(.linear)
                    .foregroundStyle(by: .value("Type", chart.type))
                
                PointMark(x: .value("Day", chart.date), y: .value("Mood", chart.mood.rawValue))
                    .interpolationMethod(.linear)
                    .foregroundStyle(by: .value("Type", chart.type))
                
//                RuleMark(y: .value("Value", -1))
            }
            .chartForegroundStyleScale([
                "Smoking sessions": .purple, "Marked moods": .mint
            ])
            .chartXScale(range: .plotDimension(padding: Spacings.spacing20))
            .chartYScale(range: .plotDimension(padding: .zero))
            .animation(.easeInOut(duration: 0.7), value: dataForCharts)
        }
        
    }
}
//
struct MoodChartView_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = [ChartModel]()
        MoodChartView(dataForCharts: mockData, state: .loading)
    }
}
