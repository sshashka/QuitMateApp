//
//  TimeAndScoreView.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.04.2023.
//

import SwiftUI

struct TimeAndScoreView: View {
    @Binding var quittingDuration: String
    var body: some View {
        Group {
            TextView(text: quittingDuration, font: .poppinsSemiBold, size: 18)
            TextView(text: "Quitting Duration", font: .poppinsMedium, size: 14)
            HStack(alignment: .center) {
                Image("ScoreImage")
                    .resizable()
                    .frame(width: 17, height: 10)
                TextView(text: "Your score is better than 85% of other users", font: .poppinsRegular, size: 14)
            }
            Spacer()
        }
    }
}

struct TimeAndScoreView_Previews: PreviewProvider {
    static var previews: some View {
        @State var quitiingDuration = "3m 28d"
        TimeAndScoreView(quittingDuration: $quitiingDuration)
    }
}
