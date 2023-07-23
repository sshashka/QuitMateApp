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
        VStack {
            Picker("Select a type of history:", selection: $selectedHistory) {
                Text("Moods")
                    .tag(TypesOfUserHistory.moods)
                Text("Timer resets")
                    .tag(TypesOfUserHistory.timerResets)
            }.pickerStyle(.segmented)
            ScrollView {
                LazyVStack {
                    ForEach(0..<100) { id in
                        Text("Sas + \(id)")
                    }
                }.padding(Spacings.spacing30)
            }
        }
    }
}

struct UserHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        UserHistoryView()
    }
}
