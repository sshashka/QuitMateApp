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
            Text("No Data")
        } else {
            Chart(dataForCharts) { day in
                PointMark(x: .value("Day", day.dateOfClassificationByDate), y: .value("Score", day.classificationString))
                    .foregroundStyle(Color(ColorConstants.labelColor))
                    .interpolationMethod(.cardinal)
            }
            .animation(.linear, value: dataForCharts.count)
        }
    }
}

struct MoodChartView_Previews: PreviewProvider {
    static var previews: some View {
        let mockData = [ChartModel(id: "mock", dateOfClassification: Date.now, classification: .happy), ChartModel(id: "mock", dateOfClassification: Date.now + 8, classification: .sad), ChartModel(id: "mock", dateOfClassification: Date.now + 9, classification: .disgust), ChartModel(id: "mock", dateOfClassification: Date.now + 25, classification: .happy), ChartModel(id: "mock", dateOfClassification: Date.now + 26, classification: .angry), ChartModel(id: "mock", dateOfClassification: Date.now + 31, classification: .surprise), ChartModel(id: "mock", dateOfClassification: Date.now + 124, classification: .fear), ChartModel(id: "mock", dateOfClassification: Date.now + 512, classification: .neutral)]
        MoodChartView(dataForCharts: mockData, state: .loading)
    }
}
