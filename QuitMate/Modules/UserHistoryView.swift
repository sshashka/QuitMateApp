//
//  UserHistoryView.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.07.2023.
//

import SwiftUI

struct UserHistoryView: View {
    enum TypesOfUserHistory: Hashable {
        case timerResets, moods
    }
    @State var selectedHistory: TypesOfUserHistory = .moods
    var body: some View {
        Picker("", selection: $selectedHistory) {
            Text("Moods")
                .tag(TypesOfUserHistory.moods)
            Text("Timer resets")
                .tag(TypesOfUserHistory.timerResets)
        }.pickerStyle(.segmented)
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView()
    }
}
