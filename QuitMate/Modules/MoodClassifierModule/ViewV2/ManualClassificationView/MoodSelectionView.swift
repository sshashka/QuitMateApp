//
//  MoodSelectionView.swift
//  QuitMate
//
//  Created by Саша Василенко on 28.04.2023.
//

import SwiftUI

struct MoodSelectionView: View {
    @Binding var moods: [ClassifiedMood]
    @Binding var selectedMood: ClassifiedMood?
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach($moods, id: \.self) { $moodLabel in
                    MoodClassifierButton(labelText: $moodLabel, selectedMood: $selectedMood)
                }
            }
        }
    }
}
