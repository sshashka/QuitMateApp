//
//  TextFieldWithUnderlineView.swift
//  QuitMate
//
//  Created by Саша Василенко on 10.06.2023.
//

import SwiftUI

struct TextFieldWithUnderlineView: View {
    var headerText: String
    @Binding var text: String
    var placeHolderText: String
    var body: some View {
        VStack(spacing: Spacings.spacing10) {
            FirstTimeEntryHeaderView(text: headerText)
            Spacer()
            TextField(placeHolderText, text: $text)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(ColorConstants.buttonsColor))
                .font(.custom(FontsEnum.poppinsMedium.rawValue, size: 24))
            Divider()
                .frame(height: 2)
                .background(Color(ColorConstants.buttonsColor))
            Spacer()
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct TextFieldWithUnderlineView_Previews: PreviewProvider {
    static var previews: some View {
        let color = Color(ColorConstants.buttonsColor)
        let header = "What should we call you"
        let placeholderText = "Your name"
        @State var text: String = ""
//        TextFieldWithUnderlineView(deviderColor: $color, placeholderText: $placeholderText)
        TextFieldWithUnderlineView(headerText: header, text: $text, placeHolderText: placeholderText)
    }
}
