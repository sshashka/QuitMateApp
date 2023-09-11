//
//  MainScreenView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct MainScreenView<ViewModel>: View where ViewModel: MainScreenViewModelProtocol {
    @State private var resetButtonPressed: Bool = false
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack {
            Group {
                HStack {
                    HeaderView(dateInString: viewModel.todayDate)
                    Button {
                        viewModel.didTapOnSettings()
                    } label: {
                        Image(systemName: SystemIconConstants.gearShape)
                            .font(.system(size: 35))
                            .foregroundColor(Color.labelColor)
                    }
                }
                UserProgressView(percentage: viewModel.percentsToFinish)
                    .foregroundColor(Color.labelColor)
            }.padding(.horizontal, Spacings.spacing20)
            Spacer(minLength: Spacings.spacing10)
            VStack (spacing: Spacings.spacing20){
                // TODO: Rename TimeAndScoreView
                TimeAndScoreView(quittingDuration: viewModel.dateComponentsWithoutSmoking)
                    .foregroundColor(Color.labelColor)
                    .padding(.top, Spacings.spacing5)
                QuittingInformationView().environmentObject(viewModel)
            }
            .padding(.horizontal, Spacings.spacing30)
            Spacer(minLength: Spacings.spacing15)
            Button {
                viewModel.didTapOnReset()
            } label: {
                Text("I smoked")
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.horizontal, Spacings.spacing30)
            Spacer(minLength: Spacings.spacing15)
        }
        .sheet(isPresented: $viewModel.isPresentingSheet) {
            if let viewModel = viewModel.additionalInfoViewModel {
                AdditionalInfoView(viewModel: viewModel)
                    .presentationDetents([.fraction(0.45)])
                    .presentationDragIndicator(.visible)
            }
        }
    }
}
struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var vm = MainScreenViewModel(storageService: FirebaseStorageService())
        MainScreenView(viewModel: vm)
    }
}
