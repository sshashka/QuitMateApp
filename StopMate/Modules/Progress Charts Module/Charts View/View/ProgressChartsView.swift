//
//  ProgressChartsModuleMainScreen.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI
import SkeletonUI

struct ProgressChartsView<ViewModel>: View where ViewModel: ProgressChartsViewModelProtocol {
    @StateObject var viewModel: ViewModel
    @State var isPresentingSheet = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: Spacings.spacing25) {
                    MoodChartView(dataForCharts: viewModel.weekDataForCharts, state: viewModel.state)
                        .frame(maxHeight: .infinity)
                        .skeleton(with: viewModel.state == .loading)
                        .shape(type: .rectangle)
                    FilterMenuView(selectedFilteringMethod: $viewModel.selectedSotringMethod)
                        .padding(.top, Spacings.spacing15)
                        .fixedSize()
                    MoodChartView(dataForCharts: viewModel.filteredDataForCharts, state: viewModel.state)
                        .padding(.top, Spacings.spacing10)
                        .frame(maxHeight: .infinity)
                        .skeleton(with: viewModel.state == .loading)
                        .shape(type: .rectangle)
                }.padding(Spacings.spacing10)
                Spacer(minLength: Spacings.spacing15)
                HStack {
                    Button(action: {
                        viewModel.didTapOnAddingMood()
                    }, label: {
                        Text("Mark new mood")
                    })
                    .buttonStyle(StandartButtonStyle())
                    Button(action: {
                        isPresentingSheet.toggle()
                    }, label: {
                        Text("Detailed info")
                    })
                    .buttonStyle(StandartButtonStyle())
                    .isEnabled(viewModel.isDetailedChartsEnabled)
                }
                .padding(.horizontal, Spacings.spacing30)
                Spacer(minLength: Spacings.spacing15)
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
        .alert(viewModel.alertText, isPresented: $viewModel.isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
