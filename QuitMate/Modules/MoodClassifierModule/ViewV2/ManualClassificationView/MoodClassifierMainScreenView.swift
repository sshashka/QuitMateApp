//
//  MoodClassifierMainScreenView.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct MoodClassifierMainScreenView: View {
    @StateObject var viewModel = MoodClassifierModuleViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            TextView(text: "Hey Sasha", font: .poppinsRegular, size: 18)
            TextView(text: "What`s in your mind", font: .poppinsRegular, size: 18)
            TextView(text: "I feel...", font: .poppinsLight, size: 14)
            MoodSelectionView(moods: $viewModel.moodsArray, selectedMood: $viewModel.selectedMood)
            Button {
                viewModel.didTapOnDoneButton()
            } label: {
                TextView(text: "Done", font: .poppinsBold, size: 14)
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
        MoodClassifierMainScreenView()
    }
}
