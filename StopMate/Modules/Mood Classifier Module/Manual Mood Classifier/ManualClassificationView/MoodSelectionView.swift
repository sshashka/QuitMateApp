//
//  MoodSelectionView.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct MoodSelectionView: View {
    var moods: [ClassifiedMood]
    @Binding var selectedMood: ClassifiedMood?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(moods, id: \.self) { mood in
                    Button {
                        selectedMood = mood
                    } label: {
                        HStack {
                            Text(mood.rawValue)
                            if selectedMood == mood {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                    .buttonStyle(StandartButtonStyle())
                }
            }.animation(.easeIn(duration: 2), value: moods)
        }
    }
}

struct MoodSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let moods = ClassifiedMood.allCases
        @State var selectedMood: ClassifiedMood? = nil
        MoodSelectionView(moods: moods, selectedMood: $selectedMood)
    }
}

