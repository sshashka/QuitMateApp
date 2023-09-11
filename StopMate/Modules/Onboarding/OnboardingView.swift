//
//  OnboardingView.swift
//  StopMate
//
//  Created by Саша Василенко on 15.08.2023.
//

import SwiftUI

struct OnboardingView<ViewModel>: View where ViewModel: OnboardingViewModelProtocol {
    @ObservedObject var viewModel: ViewModel
    var body: some View {
        TabView {
            OnboardingTab(headerText: "Smoking session", icon: IconConstants.timerReset, systemIcon: nil, description: "If you still couldn't hold back and started smoking again tap on 'I smoked' button on main menu to add a record about your emotional state and so.")
            OnboardingTab(headerText: "Viewing your moods", icon: nil, systemIcon: SystemIconConstants.chart, description: "To see all of your marked moods throughout the period of use of this app just tap on charts icon on the bottom")
            OnboardingTab(headerText: "Seeing detailed info", icon: IconConstants.chartDetails, systemIcon: nil, description: "To see more of mood-related data just tap on the button that says 'Detailed info' on the bottom of charts screen")
            OnboardingTab(headerText: "Marking new mood", icon: IconConstants.moodIcon, systemIcon: nil, description: "You can mark your mood on the charts tab. Just tap on the button that says 'Mark new mood' and select your mood. But be careful you can do this only once a day!")
            OnboardingTab(headerText: "Changing settings", icon: nil, systemIcon: SystemIconConstants.gearShape, description: "If you need to change some information about you or see your history of interactions with the app go to main screen an tap on the gear icon")
            OnboardingTab(headerText: "Tutorial", icon: IconConstants.onboarding, systemIcon: nil, description: "If you feel that you need to see this tutorial once again just go to settings and tap on 'Tutorial' button")
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    viewModel.didTapOnClose()
                } label: {
                    Image(systemName: SystemIconConstants.close)
                        .foregroundColor(Color.labelColor)
                        .font(.system(size: 22))
                        .padding(.leading, Spacings.spacing15)
                }
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(viewModel: OnboardingViewModel(storageService: FirebaseStorageService()))
    }
}
