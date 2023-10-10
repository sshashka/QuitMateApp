//
//  ProgressView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct UserProgressView: View {
//    @State var isLoading: Bool
    var percentage: Double
    var body: some View {
        Circle()
            .trim(from: 0, to: CGFloat(percentage))
            .stroke(Color.buttonsPurpleColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .rotationEffect(Angle(degrees: -90))
            .glow(color: Color.buttonsPurpleColor, radius: 10)
            .animation(.easeIn(duration: 2), value: percentage)
            .overlay {
                ProgressPercentageView(percentage: percentage)
                    .padding(.vertical, Spacings.spacing30)
            }
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let percentage: Double = 25.0
        UserProgressView(percentage: percentage)
    }
}
