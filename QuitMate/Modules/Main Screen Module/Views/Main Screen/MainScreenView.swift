//
//  MainScreenView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct MainScreenView: View {
    @State private var resetButtonPressed: Bool = false
    @StateObject var viewModel: MainScreenViewModel
    var body: some View {
        VStack {
            Group {
                HStack {
                    HeaderView(dateInString: viewModel.todayDate)
                    SettingsButton().environmentObject(viewModel)
                }
                UserProgressView(percentage: viewModel.percentsToFinish)
                    .foregroundColor(Color(ColorConstants.labelColor))
            }.padding([.horizontal], 20)
            Group {
                TimeAndScoreView(quittingDuration: viewModel.dateComponentsWithoutSmoking)
                    .foregroundColor(Color(ColorConstants.labelColor))
                    .padding(.top, Spacings.spacing5)
                QuittingInformationView(moneySpentOnCigarets: viewModel.moneySaved, daysWithoutSmoking: viewModel.daysWithoutSmoking, enviromentalChanges: viewModel.enviromentalChanges, daysToFinish: viewModel.daysToFinish)
                    .cornerRadius(35, corners: [.topLeft, .topRight])
            }.padding(.horizontal, Spacings.spacing30)
            Spacer(minLength: Spacings.spacing15)
            Button {
                resetButtonPressed.toggle()
            } label: {
                Text("Reset Progress")
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.horizontal, Spacings.spacing30)
            Spacer(minLength: Spacings.spacing15)
                .alert("Do you want to reset timer? (note: this operation cannot be undone)", isPresented: $resetButtonPressed) {
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
