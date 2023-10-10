//
//  MoodClassifierMainScreenView.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct ManualMoodClassifierView<ViewModel>: View where ViewModel: ManualMoodClassifierModuleViewModelProtocol {
    @StateObject var viewModel: ViewModel
    let vibrationGenerator = UINotificationFeedbackGenerator()
    var body: some View {
        VStack(alignment: .center) {
            Text(Localizables.MoodModuleStrings.hey)
                .modifier(TextViewModifier(font: .regular, size: 18))
            Text(Localizables.MoodModuleStrings.whatIsInYourMind)
                .modifier(TextViewModifier(font: .regular, size: 18))
            Text(Localizables.MoodModuleStrings.iFeel)
                .modifier(TextViewModifier(font: .light, size: 18))
            MoodSelectionView(moods: viewModel.moodsArray, selectedMood: $viewModel.selectedMood)
            Spacer(minLength: Spacings.spacing20)
            Button {
                viewModel.didTapOnDoneButton()
                vibrationGenerator.notificationOccurred(.success)
            } label: {
                Text(Localizables.Shared.done)
            }
            .buttonStyle(StandartButtonStyle())
        }
        .padding(Spacings.spacing15)
        .onChange(of: viewModel.selectedMood) { selectedMood in
            if let selectedMood = selectedMood {
                viewModel.handleMoodSelection(selectedMood: selectedMood)
            }
        }
    }
}

struct MoodClassifierMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        ManualMoodClassifierView(viewModel: ManualMoodClassifierModuleViewModel(storageService: FirebaseStorageService()))
    }
}
