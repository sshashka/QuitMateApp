//
//  DetailedChartsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 01.08.2023.
//

import SwiftUI
import Charts

struct DetailedChartsView<ViewModel>: View where ViewModel: DetailedChartsViewModel {
    @EnvironmentObject var viewModel: ViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: Spacings.spacing20) {
                Chart(viewModel.progressChartStats) { data in
                    BarMark(x: .value("", data.count), y: .value("", data.mood.rawValue))
                }.frame(height: 200)
                Text(viewModel.moodsCountText)
                    .fontStyle(.poppinsSemibold16)
                Divider()
                    .frame(height: 1)
                Chart(viewModel.progressChartStats) { data in
                    BarMark(x: .value("", data.count), y: .value("", data.monthAndYear))
                        .foregroundStyle(by: .value("", data.mood.rawValue))
                }.frame(height: 200)
                Text(viewModel.monthsDetailsText)
                    .fontStyle(.poppinsSemibold16)
            }.padding(Spacings.spacing30)
        }.onAppear {
            viewModel.start()
        }
    }
}

struct DetailedChartsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedChartsView()
    }
}
