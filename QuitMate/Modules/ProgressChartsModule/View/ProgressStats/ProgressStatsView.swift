//
//  ProgressStatsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI

struct ProgressStatsView: View {
    let titleText: String
    let secondaryText: String
    var body: some View {
        VStack(alignment: .leading) {
            TextView(text: titleText, font: .poppinsSemiBold, size: 18)
                .foregroundColor(Color(ColorConstants.purpleColor))
            TextView(text: secondaryText, font: .poppinsLight, size: 14)
                .lineLimit(2)
        }
    }
}

struct ProgressStatsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressStatsView(titleText: "Sas", secondaryText: "Says")
    }
}
