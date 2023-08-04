//
//  ProgressChartsModuleMainScreen.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI

struct ProgressChartsModuleMainScreen: View {
    @StateObject var viewModel: ProgressChartsViewModel
    @State var isPresentingSheet = false
    var body: some View {
        NavigationStack {
            GeometryReader { frame in
                VStack(spacing: Spacings.spacing20) {
                    MoodChartView(dataForCharts: viewModel.weekDataForCharts, state: viewModel.state)
                        .frame(height: frame.size.height * 3/10)
                    
                    FilterMenuView(selectedFilteringMethod: $viewModel.selectedSotringMethod)
                        .frame(height: frame.size.height * 1/20)
                        .padding(.top, Spacings.spacing15)
                    
                    MoodChartView(dataForCharts: viewModel.dataForCharts, state: viewModel.state)
                        .padding(.top, Spacings.spacing10)
                        .frame(height: frame.size.height * 4/10)
                    Spacer()
                    Button(action: {
                        isPresentingSheet.toggle()
                    }, label: {
                        Text("Tap to see more detailed info")
                    })
                    .buttonStyle(StandartButtonStyle())
                    Spacer()
                }
            }.padding(Spacings.spacing20)
                .onAppear {
                    viewModel.start()
                }
        }.toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text("Chart for this week")
                    .fontStyle(.poppinsSemibold18)
            }
        })
            .sheet(isPresented: $isPresentingSheet) {
                DetailedChartsView().environmentObject(viewModel.getDetailedInfoViewModel())
                    .presentationDragIndicator(.visible)
            }
    }
}
