//
//  FirstTimeEntryHeaderView.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.06.2023.
//

import SwiftUI

struct FirstTimeEntryHeaderView: View {
    let text: String
    var body: some View {
        Text(text)
            .foregroundColor(.gray)
            .fontStyle(.greyHeaderText)

    }
}

struct FirstTimeEntryHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeEntryHeaderView(text: "What should we call you?")
    }
}
