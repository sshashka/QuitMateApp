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
            PeriodOfTimeToQuitView(period: .finishingDate, headerText: Localizables.UserSmokedModuleStrings.setNewFinishingDate, datePickerText: Localizables.FirstTimeEntryStrings.finishingDate, date: $viewModel.newDate)
            Spacer()
            Button {
                viewModel.doNotChangeFinishingDate()
            } label: {
                Text(Localizables.UserSmokedModuleStrings.dontChangeFinishingDate)
                    .fontStyle(.clearButtonsText)
            }
            Button {
                viewModel.updateValue()
            } label: {
                Text(Localizables.Shared.finish)
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
