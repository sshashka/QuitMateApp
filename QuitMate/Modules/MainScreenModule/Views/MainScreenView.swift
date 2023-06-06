//
//  MainScreenView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct MainScreenView: View {
    @StateObject var viewModel: MainScreenViewModel
    var body: some View {
        GeometryReader { frame in
            VStack {
                Group {
                    HeaderView(dateInString: $viewModel.todayDate)
                    ProgressView(percentage: $viewModel.percentsToFinish)
                        .foregroundColor(Color(ColorConstants.labelColor))
                        .frame(width: frame.size.width / 2 + Spacings.spacing40)
                }
                .padding([.horizontal], 20)
                Group {
                    TimeAndScoreView(quittingDuration: $viewModel.dateComponentsWithoutSmoking)
                        .foregroundColor(Color(ColorConstants.labelColor))
                        .padding(.top, Spacings.spacing5)
                    QuittingInformationView(moneySpentOnCigarets: $viewModel.moneySaved, daysFree: $viewModel.daysWithoutSmoking, enviromentalChanges: $viewModel.enviromentalChanges, daysToFinish: $viewModel.daysToFinish, userConfirmedReset: $viewModel.userConfirmedRequest)
                        .background(Color.white)
                        .cornerRadius(35, corners: [.topLeft, .topRight])
                        .frame(height: frame.size.height / 2 - Spacings.spacing40)
                }
            }
        }
    }
}
struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        @StateObject var vm = MainScreenViewModel()
        MainScreenView(viewModel: vm)
    }
}
