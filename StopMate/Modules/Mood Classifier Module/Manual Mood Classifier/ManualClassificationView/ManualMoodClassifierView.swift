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
            Text("Hey")
                .modifier(TextViewModifier(font: .poppinsRegular, size: 18))
            Text("What`s in your mind")
                .modifier(TextViewModifier(font: .poppinsRegular, size: 18))
            Text("I feel...")
                .modifier(TextViewModifier(font: .poppinsLight, size: 14))
            MoodSelectionView(moods: viewModel.moodsArray, selectedMood: $viewModel.selectedMood)
            Spacer(minLength: Spacings.spacing20)
            Button {
                viewModel.didTapOnDoneButton()
                vibrationGenerator.notificationOccurred(.success)
            } label: {
                Text("Done")
                    .modifier(TextViewModifier(font: .poppinsBold, size: 14))
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
