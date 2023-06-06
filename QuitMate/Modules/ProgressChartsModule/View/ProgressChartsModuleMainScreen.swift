//
//  ProgressChartsModuleMainScreen.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI

struct ProgressChartsModuleMainScreen: View {
    @StateObject var viewModel = ProgressChartsViewModel()
    
    var body: some View {
        
        GeometryReader { frame in
            VStack(spacing: Spacings.spacing20) {
                MoodChartView(dataForCharts: $viewModel.weekDataForCharts)
                    .frame(height: frame.size.height * 2/10)
                Group {
                    ProgressStatsViewContainer(bestDay: $viewModel.bestDay, worstDay: $viewModel.worstDay, bestScore: $viewModel.bestDayScore, worstScore: $viewModel.worstDayScore)
                        .frame(height: frame.size.height * 3/10)
                    FilterMenuView(selectedFilteringMethod: $viewModel.selectedSotringMethod)
                        .frame(height: frame.size.height * 1/20)
                }.padding(.horizontal, Spacings.spacing20)
                MoodChartView(dataForCharts: $viewModel.dataForCharts)
                    .padding(.top, Spacings.spacing10)
                //                        .frame(height: frame.size.height * 4/10)
            }
        }
    }
}
//
//struct ProgressChartsModuleMainScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressChartsModuleMainScreen()
//    }
//}
