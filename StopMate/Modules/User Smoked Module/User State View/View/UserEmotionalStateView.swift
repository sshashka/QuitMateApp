//
//  UserEmotionalStateView.swift
//  StopMate
//
//  Created by Саша Василенко on 28.08.2023.
//

import SwiftUI

struct UserEmotionalStateView<ViewModel>: View where ViewModel: UserEmotionalStateViewModelProtocol {
    @StateObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(Localizables.UserSmokedModuleStrings.tellUsAboutEmotionalState)
                .fontStyle(.customMedium20)
            Text(Localizables.UserSmokedModuleStrings.urgeToSmokePromt)
                .fontStyle(.customSemibold16)
            SmokeUrgeButtonGrid(selection: $viewModel.urgeToSmokeValue)
            Spacer(minLength: Spacings.spacing25)
            Text(Localizables.UserSmokedModuleStrings.howDidYouFeel)
                .fontStyle(.customSemibold16)
            MoodSelectionView(moods: ClassifiedMood.allCases, selectedMood: $viewModel.selectedMood)
            Spacer(minLength: Spacings.spacing15)
            Button {
                viewModel.isDoneButtonEnabled ? self.vibrate(event: .success) : self.vibrate(event: .fail)
                viewModel.didTapOnDoneButton()
            } label: {
                Text(Localizables.Shared.next)
            }
            .buttonStyle(StandartButtonStyle())
            .isEnabled(viewModel.isDoneButtonEnabled)
        }
        .padding(.horizontal, Spacings.spacing30)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: SystemIconConstants.close)
                    .padding()
                    .onTapGesture {
                        viewModel.didTapOnCloseButton()
                    }
            }
        }
    }
}

struct UserEmotionalStateView_Previews: PreviewProvider {
    static var previews: some View {
        UserEmotionalStateView(viewModel: UserEmotionalStateViewModel(storageService: FirebaseStorageService()))
    }
}
