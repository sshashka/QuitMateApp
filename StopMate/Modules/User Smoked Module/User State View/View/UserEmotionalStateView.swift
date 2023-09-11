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
           Text("Please tell us about your emotional state")
                .fontStyle(.poppinsMedium20)
            Text("How strong was your urge to smoke?")
                .fontStyle(.poppinsSemibold16)
            SmokeUrgeButtonGrid(selection: $viewModel.urgeToSmokeValue)
            Spacer(minLength: Spacings.spacing25)
            Text("How did you feel when it happened")
                .fontStyle(.poppinsSemibold16)
            MoodSelectionView(moods: ClassifiedMood.allCases, selectedMood: $viewModel.selectedMood)
            Spacer(minLength: Spacings.spacing15)
            Button {
                viewModel.didTapOnDoneButton()
            } label: {
                Text("Done")
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
