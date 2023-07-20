//
//  ProgressChartsModuleMainScreen.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI

struct ProgressChartsModuleMainScreen: View {
    @StateObject var viewModel: ProgressChartsViewModel
    
    var body: some View {
        NavigationStack {
            GeometryReader { frame in
                VStack(spacing: Spacings.spacing20) {
                    if viewModel.weekDataForCharts.count == 0 {
                        Text("No data")
                            .fontStyle(.header)
                            .frame(height: frame.size.height * 2/10)
                    } else {
                        MoodChartView(dataForCharts: viewModel.weekDataForCharts, state: viewModel.state)
                            .frame(height: frame.size.height * 2/10)
                    }
                    Group {
                        ProgressStatsViewContainer(bestDay: viewModel.bestDay, worstDay: viewModel.worstDay, bestScore: viewModel.bestDayScore, worstScore: viewModel.worstDayScore)
                            .frame(height: frame.size.height * 3/10)
                        FilterMenuView(selectedFilteringMethod: $viewModel.selectedSotringMethod)
                            .frame(height: frame.size.height * 1/20)
                    }
                    // Add a delay
                    if viewModel.dataForCharts.count == 0 {
                        Text("No data")
                            .fontStyle(.header)
                            .padding(.top, Spacings.spacing10)
                        
                    } else {
                        MoodChartView(dataForCharts: viewModel.dataForCharts, state: viewModel.state)
                            .padding(.top, Spacings.spacing10)
                    }
                    //                        .frame(height: frame.size.height * 4/10)
                }
            }.padding(Spacings.spacing20)
        }.navigationTitle("Chart for this week")
    }
}

//struct ProgressChartsModuleMainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressChartsModuleMainScreen(viewModel: ProgressChartsViewModel())
//    }
//}
