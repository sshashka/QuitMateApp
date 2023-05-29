//
//  LongAssText.swift
//  QuitMate
//
//  Created by Саша Василенко on 22.05.2023.
//

import SwiftUI

struct LongAssText: View {
    var body: some View {
        VStack {
            ScrollView {
                Text("Some LongAss Text Some LongAss Text Some LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss Text Some LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss Text Some LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss Text Some LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text Some LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss TextSome LongAss Text")
            }
            Button {
                print("sas")
            } label: {
                TextView(text: "Done", font: .poppinsBlack, size: 14)
            }.buttonStyle(StandartButtonStyle())
        }
        .padding(Spacings.spacing25)
    }
}

struct LongAssText_Previews: PreviewProvider {
    static var previews: some View {
        LongAssText()
    }
}
