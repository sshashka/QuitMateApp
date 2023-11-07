//
//  MilestoneCompletedView.swift
//  StopMate
//
//  Created by Саша Василенко on 16.10.2023.
//

import SwiftUI

struct MilestoneCompletedView<ViewModel>: View where ViewModel: MilestoneCompletedViewModelProtocol {
    let vm: ViewModel
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacings.spacing15) {
                Text(Localizables.MilestoneCompletedStrings.header)
                    .fontStyle(.header)
                Text(Localizables.MilestoneCompletedStrings.bottomText)
                    .fontStyle(.recomendationsText)
                Button {
                    vm.didTapOnDontChangeAnything()
                } label: {
                    Text(Localizables.MilestoneCompletedStrings.continueUsingAsDiary)
                }
                
                Button {
                    vm.didTapOnResetFinishingDate()
                } label: {
                    Text(Localizables.MilestoneCompletedStrings.setANewDate)
                }

            }
            .buttonStyle(StandartButtonStyle())
            .padding(Spacings.spacing30)
        }
        .background(CirclesBackgroundView().opacity(0.6))
    }
}

#Preview {
    MilestoneCompletedView(vm: MilestoneCompletedViewModel())
}
