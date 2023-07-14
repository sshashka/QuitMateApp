//
//  CurrencyView.swift
//  QuitMate
//
//  Created by Саша Василенко on 14.06.2023.
//

import SwiftUI

enum Currency: String, Hashable, Codable {
    case uah = "uah"
    case usd = "usd"
}

struct CurrencyPicker: View {
    @State var selection: Currency = .uah
    private let currencies = [Currency.uah, Currency.usd]
    var body: some View {
        Picker("Appearence", selection: $selection) {
            ForEach(currencies, id: \.self) {
                Text($0.rawValue)
            }
        }.pickerStyle(.wheel)
    }
}

struct CurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyPicker()
    }
}
