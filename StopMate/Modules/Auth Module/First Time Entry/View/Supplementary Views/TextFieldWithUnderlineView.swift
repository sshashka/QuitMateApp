//
//  TextFieldWithUnderlineView.swift
//  StopMate
//
//  Created by Саша Василенко on 10.08.2023.
//

import SwiftUI

struct TextFieldWithUnderlineView: View {
    @Binding var text: String
    let placeHolderText: String
    var body: some View {
        VStack {
            TextField(placeHolderText, text: $text)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.buttonsPurpleColor)
                .font(.custom(FontsEnum.medium.rawValue, size: 24))
            Divider()
                .frame(height: 2)
            .background(Color.buttonsPurpleColor)
        }
    }
}

struct TextFieldWithUnderlineView_Previews: PreviewProvider {
    static var previews: some View {
        @State var text: String = ""
        TextFieldWithUnderlineView(text: $text, placeHolderText: "mock")
    }
}
