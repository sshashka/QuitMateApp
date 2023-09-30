//
//  HeadingView.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.04.2023.
//

import SwiftUI

struct HeaderView: View {
    let dateInString: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(Localizables.quittingAnalysis)
                    .modifier(TextViewModifier(font: .semiBold, size: 18))
                    .minimumScaleFactor(0.7)
                Text(dateInString)
                    .modifier(TextViewModifier(font: .medium, size: 14))
                    .minimumScaleFactor(0.7)
            }
            Spacer()
        }
        .padding([.horizontal])
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDate = "May 10, 2023"
        HeaderView(dateInString: mockDate)
    }
}
