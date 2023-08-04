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
            Button {
                viewModel.updateValue()
            } label: {
                Text("Finish")
            }.buttonStyle(StandartButtonStyle())
                .padding(Spacings.spacing30)
        }
    }
}
