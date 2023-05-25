//
//  NameEntry.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.05.2023.
//

import SwiftUI

struct NameEntry: View {
    @State var text: String = ""
    var body: some View {
        VStack(spacing: Spacings.spacing15) {
            TextField("Your name", text: $text)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(ColorConstants.purpleColor))
            Divider()
                .frame(height: 1)
                .background(Color(ColorConstants.purpleColor))
            Spacer()
            Button {
                print("Sas")
            } label: {
                TextView(text: "Next step", font: .poppinsSemiBold, size: 14)
            }.buttonStyle(StandartButtonStyle())

        }
        .padding(.horizontal, Spacings.spacing30)
    }
}

struct NameEntry_Previews: PreviewProvider {
    static var previews: some View {
        NameEntry()
    }
}
