//
//  StatsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct StatsView: View {
    let titleText: String
    let secondaryText: String
    var body: some View {
        HStack(alignment: .center) {
            Image("Money")
                .resizable()
                .frame(width: 55, height: 55)
            VStack(alignment: .leading) {
                TextView(text: titleText, font: .poppinsSemiBold, size: 18)
                TextView(text: secondaryText, font: .poppinsLight, size: 14)
                    .lineLimit(2)
            }
        }
        .minimumScaleFactor(0.6)
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(titleText: "120", secondaryText: "Days without smoking")
    }
}
