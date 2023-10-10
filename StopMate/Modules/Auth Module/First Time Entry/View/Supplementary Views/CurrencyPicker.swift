//
//  CurrencyView.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.06.2023.
//

import SwiftUI

struct CurrencyPicker: View {
    @Binding var selection: Currency
    @Binding var text: String
    let placeHolderText: String
    let headerText: String
    private let currencies = [Currency.uah, Currency.usd]
    var body: some View {
        VStack {
            FirstTimeEntryHeaderView(text: headerText)
            Spacer()
            HStack {
                TextFieldWithUnderlineView(text: $text, placeHolderText: placeHolderText)
                VStack {
                    Picker("", selection: $selection) {
                        ForEach(currencies, id: \.self) {
                            Text($0.rawValue)
                        }
                    }
                    .pickerStyle(.automatic)
                    .foregroundColor(.green)
                    Divider()
                        .frame(height: 2)
                        .background(Color.buttonsPurpleColor)
                }
                
            }
            Spacer()
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        @State var text = ""
        @State var selectedCurrency = Currency.uah
        let placeHolderText = "dsdasdadasd"
        CurrencyPicker(selection: $selectedCurrency, text: $text, placeHolderText: placeHolderText, headerText: "KKKKKKKKK")
    }
}
