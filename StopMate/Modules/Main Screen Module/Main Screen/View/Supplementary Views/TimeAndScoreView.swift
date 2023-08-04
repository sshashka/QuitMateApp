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
                .modifier(TextViewModifier(font: .poppinsSemiBold, size: 18))
            Text("Quitting Duration")
                .modifier(TextViewModifier(font: .poppinsMedium, size: 14))
        }
    }
}

struct TimeAndScoreView_Previews: PreviewProvider {
    static var previews: some View {
        var quitiingDuration = "3m 28d"
        TimeAndScoreView(quittingDuration: quitiingDuration)
    }
}
