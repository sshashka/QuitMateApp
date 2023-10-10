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
            OnboardingTab(headerText: Localizables.OnboardingStrings.smokingSessionHeader, icon: IconConstants.timerReset, systemIcon: nil, description: Localizables.OnboardingStrings.smokingSessionDescription)
            OnboardingTab(headerText: Localizables.OnboardingStrings.viewMoodsHeader, icon: nil, systemIcon: SystemIconConstants.chart, description: Localizables.OnboardingStrings.viewMoodsDescription)
            OnboardingTab(headerText: Localizables.OnboardingStrings.onboardingDetailedInfoHeader, icon: IconConstants.chartDetails, systemIcon: nil, description: Localizables.OnboardingStrings.onboardingDetailedInfoDescription)
            OnboardingTab(headerText: Localizables.OnboardingStrings.markingNewMoodHeader, icon: IconConstants.moodIcon, systemIcon: nil, description: Localizables.OnboardingStrings.markingNewMoodDescription)
            OnboardingTab(headerText: Localizables.OnboardingStrings.changingSettingsHeader, icon: nil, systemIcon: SystemIconConstants.gearShape, description: Localizables.OnboardingStrings.changingSettingsDescription)
            OnboardingTab(headerText: Localizables.OnboardingStrings.onboardingHeader, icon: IconConstants.onboarding, systemIcon: nil, description: Localizables.OnboardingStrings.onboardingDescription)
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
