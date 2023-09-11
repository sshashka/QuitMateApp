//
//  DetailedChartsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.08.2023.
//

import SwiftUI
import Charts

struct DetailedChartsView<ViewModel>: View where ViewModel: DetailedChartsViewModelProtocol {
    @StateObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: Spacings.spacing20) {
                Chart(viewModel.progressChartStats) { data in
                    BarMark(x: .value("", data.count), y: .value("", data.mood.rawValue))
                }
                .frame(height: 200)
                Text(viewModel.moodsCountText)
                    .fontStyle(.poppinsSemibold16)
                Divider()
                    
                Chart(viewModel.progressChartStats) { data in
                    BarMark(x: .value("", data.count), y: .value("", data.monthAndYear))
                        .foregroundStyle(by: .value("", data.mood.rawValue))
                }
                .frame(height: 200)
                
                Text(viewModel.monthsDetailsText)
                    .fontStyle(.poppinsSemibold16)
                Divider()
                
                HStack(alignment: .top) {
                    CorrelationView(correlation: viewModel.correlation)
                        .padding(.horizontal)
                    Text("This bar shows you correlation between your daily moods and moods when you smoked. The bigger value means stronger correlation")
                        .fontStyle(.poppinsSemibold16)
                }.frame(height: 200)
            }
            .padding(Spacings.spacing30)
        }.onAppear {
            viewModel.start()
        }
    }
}

struct DetailedChartsView_Previews: PreviewProvider {
    static var previews: some View {
        let data = [UserMoodModel]()
        let vm = DetailedChartsViewModel(data: data, correlation: 0.5)
        DetailedChartsView(viewModel: vm)
    }
}
