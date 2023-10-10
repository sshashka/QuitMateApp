//
//  TimeAndScoreView.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.04.2023.
//

import SwiftUI

struct TimeAndScoreView: View {
    var quittingDuration: String
    var body: some View {
        VStack {
            Text(quittingDuration)
                .modifier(TextViewModifier(font: .semiBold, size: 18))
            Text(Localizables.MainScreen.quittingDuration)
                .modifier(TextViewModifier(font: .medium, size: 14))
        }
    }
}

struct TimeAndScoreView_Previews: PreviewProvider {
    static var previews: some View {
        let quitiingDuration = "3m 28d"
        TimeAndScoreView(quittingDuration: quitiingDuration)
    }
}
