//
//  ReasonsToStopNewFinishingDateView.swift
//  QuitMate
//
//  Created by Саша Василенко on 20.06.2023.
//

import SwiftUI

struct ReasonsToStopNewFinishingDateView: View {
    @StateObject var viewModel: ReasonsToStopNewFinishingDateViewModel
    var body: some View {
        VStack {
            PeriodOfTimeToQuitView(period: .finishingDate, headerText: "Set new finishing date", datePickerText: "Finishing date", date: $viewModel.newDate)
            Spacer()
            Button {
                viewModel.doNotChangeFinishingDate()
            } label: {
                Text("Don`t change the finishing date")
                    .fontStyle(.clearButtonsText)
            }
            Button {
                viewModel.updateValue()
            } label: {
                Text("Finish")
            }.buttonStyle(StandartButtonStyle())
                .padding(Spacings.spacing30)
        }
    }
}

struct ReasonsToStopNewFinishingDateView_Previews: PreviewProvider {
    static var previews: some View {
        ReasonsToStopNewFinishingDateView(viewModel: ReasonsToStopNewFinishingDateViewModel(storageService: FirebaseStorageService()))
    }
}
