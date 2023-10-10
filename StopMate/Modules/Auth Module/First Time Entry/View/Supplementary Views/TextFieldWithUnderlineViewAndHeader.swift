//
//  TextFieldWithUnderlineView.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.06.2023.
//

import SwiftUI

struct TextFieldWithUnderlineViewAndHeader: View {
    var headerText: String
    @Binding var text: String
    var placeHolderText: String
    var body: some View {
        VStack(spacing: Spacings.spacing10) {
            FirstTimeEntryHeaderView(text: headerText)
            Spacer()
            TextFieldWithUnderlineView(text: $text, placeHolderText: placeHolderText)
            Spacer()
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct TextFieldWithUnderlineViewAndHeader_Previews: PreviewProvider {
    static var previews: some View {
//        let color = Color(ColorConstants.buttonsColor)
        let header = "What should we call you"
        let placeholderText = "Your name"
        @State var text: String = ""
//        TextFieldWithUnderlineView(deviderColor: $color, placeholderText: $placeholderText)
        TextFieldWithUnderlineViewAndHeader(headerText: header, text: $text, placeHolderText: placeholderText)
    }
}
