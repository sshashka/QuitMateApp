//
//  MoodChartView.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.03.2023.
//

import SwiftUI
import Charts

struct MoodChartView: View {
    @Binding var dataForCharts: [ChartModel]
    
    var body: some View {
        VStack {
            Chart(dataForCharts) { day in
                LineMark(x: .value("Day", day.dateOfClassification), y: .value("Score", day.scoreForUser))
                    .foregroundStyle(Color(ColorConstants.labelColor))
                    .interpolationMethod(.cardinal)
                PointMark(x: .value("Day", day.dateOfClassification), y: .value("Score", day.scoreForUser))
                    .foregroundStyle(Color(ColorConstants.labelColor))
                    .interpolationMethod(.cardinal)
//                AreaMark(x: .value("Day", day.dateOfClassification), y: .value("Score", day.scoreForUser))
//                    .foregroundStyle(Gradient(colors: [Color(ColorConstants.labelColor), Color(uiColor: .systemBackground)]))
//                    .interpolationMethod(.cardinal)
            }
//            .chartXScale(domain: [0, dataForCharts.endIndex])
            .animation(.linear, value: dataForCharts.count)
            .scaleEffect(CGSize(width: 1, height: calculateScale()))
        }
    }
    
    private func calculateScale() -> CGFloat {
        guard let firstDate = dataForCharts.first?.dateOfClassification,
              let lastDate = dataForCharts.last?.dateOfClassification else {
            return 1.0
        }
        
        let daysBetween = Calendar.current.dateComponents([.day], from: firstDate, to: lastDate).day ?? 0
        
        // Set a minimum scale of 1.0 to avoid the chart becoming too small
        return max(1.0, CGFloat(daysBetween) / 100.0)
    }
}

struct MoodChartView_Previews: PreviewProvider {
    static var previews: some View {
        @State var mockData = [ChartModel(id: "mock", dateOfClassification: Date.now, classification: .happy), ChartModel(id: "mock", dateOfClassification: Date.now + 8, classification: .sad), ChartModel(id: "mock", dateOfClassification: Date.now + 9, classification: .disgust), ChartModel(id: "mock", dateOfClassification: Date.now + 25, classification: .happy), ChartModel(id: "mock", dateOfClassification: Date.now + 26, classification: .angry), ChartModel(id: "mock", dateOfClassification: Date.now + 31, classification: .surprise), ChartModel(id: "mock", dateOfClassification: Date.now + 124, classification: .fear), ChartModel(id: "mock", dateOfClassification: Date.now + 512, classification: .neutral)]
        MoodChartView(dataForCharts: $mockData)
    }
}
