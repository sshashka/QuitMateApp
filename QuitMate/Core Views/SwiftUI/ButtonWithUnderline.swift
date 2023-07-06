//
//  ButtonWithUnderline.swift
//  QuitMate
//
//  Created by Саша Василенко on 15.06.2023.
//

import SwiftUI

struct ButtonWithUnderline: View {
    var body: some View {
        VStack {
            Button {
                print("sas")
            } label: {
                Text("Sas")
            }
            Divider()
                .frame(height: 2)
                .background(Color(ColorConstants.buttonsColor))
        }
    }
}

struct ButtonWithUnderline_Previews: PreviewProvider {
    static var previews: some View {
        ButtonWithUnderline()
    }
}
