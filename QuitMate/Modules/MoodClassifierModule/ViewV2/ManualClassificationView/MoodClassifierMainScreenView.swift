//
//  MoodClassifierMainScreenView.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct MoodClassifierMainScreenView: View {
    @StateObject var viewModel: ManualMoodClassifierModuleViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Hey Sasha")
                .modifier(TextViewModifier(font: .poppinsRegular, size: 18))
            Text("What`s in your mind")
                .modifier(TextViewModifier(font: .poppinsRegular, size: 18))
            Text("I feel...")
                .modifier(TextViewModifier(font: .poppinsLight, size: 14))
            MoodSelectionView(moods: $viewModel.moodsArray, selectedMood: $viewModel.selectedMood)
            Button {
                viewModel.didTapOnDoneButton()
            } label: {
                Text("Done")
                    .modifier(TextViewModifier(font: .poppinsBold, size: 14))
            }
            .buttonStyle(StandartButtonStyle())
        }
        .padding(LayoutConstants.spacing16)
        .onChange(of: viewModel.selectedMood) { selectedMood in
            if let selectedMood = selectedMood {
                viewModel.handleMoodSelection(selectedMood: selectedMood)
            }
        }
    }
}

struct MoodClassifierMainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MoodClassifierMainScreenView(viewModel: ManualMoodClassifierModuleViewModel(storageService: FirebaseStorageService()))
    }
}
