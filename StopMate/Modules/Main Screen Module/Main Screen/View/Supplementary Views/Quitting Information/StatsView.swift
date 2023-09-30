//
//  StatsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct StatsView: View {
    let image: String
    let titleText: String
    let secondaryText: String
    let tintColor: Color?
    var body: some View {
        HStack(alignment: .center) {
            Image(image)
                .resizable()
                .frame(width: 55, height: 55)
                .foregroundColor(tintColor)
            VStack(alignment: .leading) {
                Text(titleText)
                    .modifier(TextViewModifier(font: .semiBold, size: 18 + 2.5))
                Text(secondaryText)
                    .modifier(TextViewModifier(font: .light, size: 14 + 2.5 ))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
        }
        .minimumScaleFactor(0.7)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .vibrate(event: .success)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(image: IconConstants.moon, titleText: "120", secondaryText: "Days without smoking", tintColor: .blue)
    }
}
