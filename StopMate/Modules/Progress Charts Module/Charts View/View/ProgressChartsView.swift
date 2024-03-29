//
//  ProgressChartsModuleMainScreen.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//
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
                    MoodChartView(dataForCharts: viewModel.weeklyChartData, domain: viewModel.weeklyChartYDomain, state: viewModel.state)
                        .frame(maxHeight: .infinity)
                        .skeleton(with: viewModel.state == .loading)
                        .shape(type: .rectangle)
                    FilterMenuView(selectedFilteringMethod: $viewModel.selectedSotringMethod)
                        .padding(.top, Spacings.spacing15)
                        .fixedSize()
                    MoodChartView(dataForCharts: viewModel.chartData, domain: viewModel.chartYDomain, state: viewModel.state)
                        .padding(.top, Spacings.spacing10)
                        .frame(maxHeight: .infinity)
                        .skeleton(with: viewModel.state == .loading)
                        .shape(type: .rectangle)
                }.padding(Spacings.spacing10)
                Spacer(minLength: Spacings.spacing15)
                HStack {
                    Button(action: {
                        viewModel.didTapOnAddingMood()
                        viewModel.isShowingAlert ? self.vibrate(event: .fail) : self.vibrate(event: .success)
                    }, label: {
                        Text(Localizables.ChartsStrings.markNewMood)
                    })
                    .lineLimit(1)
                    .buttonStyle(StandartButtonStyle())
                    Button(action: {
                        self.vibrate(event: .success)
                        isPresentingSheet.toggle()
                    }, label: {
                        Text(Localizables.ChartsStrings.detailedInfo)
                    })
                    .buttonStyle(StandartButtonStyle())
                    .isEnabled(viewModel.isDetailedChartsEnabled)
                }
                .padding(.horizontal, Spacings.spacing30)
                Spacer(minLength: Spacings.spacing15)
            }
        }.toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(Localizables.ChartsStrings.chartsWeeklyHeader)
                    .fontStyle(.customSemibold18)
            }
        })
        .sheet(isPresented: $isPresentingSheet) {
            DetailedChartsView(viewModel: viewModel.getDetailedInfoViewModel())
                .presentationDragIndicator(.visible)
        }
        .alert(viewModel.alertText, isPresented: $viewModel.isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}
