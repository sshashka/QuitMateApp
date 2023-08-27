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
                            .foregroundColor(Color(ColorConstants.labelColor))
                    }
                }
                UserProgressView(percentage: viewModel.percentsToFinish)
                    .foregroundColor(Color(ColorConstants.labelColor))
            }.padding(.horizontal, Spacings.spacing20)
            Spacer(minLength: Spacings.spacing10)
            VStack (spacing: Spacings.spacing20){
                // TODO: Rename TimeAndScoreView
                TimeAndScoreView(quittingDuration: viewModel.dateComponentsWithoutSmoking)
                    .foregroundColor(Color(ColorConstants.labelColor))
                    .padding(.top, Spacings.spacing5)
                QuittingInformationView().environmentObject(viewModel)
            }.padding(.horizontal, Spacings.spacing30)
            Spacer(minLength: Spacings.spacing15)
            Button {
                resetButtonPressed.toggle()
            } label: {
                Text("Update timer")
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.horizontal, Spacings.spacing30)
            Spacer(minLength: Spacings.spacing15)
                .alert("Do you want to update timer? (note: this operation cannot be undone)", isPresented: $resetButtonPressed) {
                    Button("Cancel", role: .cancel) {
                        resetButtonPressed.toggle()
                    }
                    Button("Yes", role: .destructive) {
                        viewModel.didTapOnReset()
                    }
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
