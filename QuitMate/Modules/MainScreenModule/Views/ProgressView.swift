//
//  ProgressView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct ProgressView: View {
    @Binding var percentage: Float
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(percentage))
                .stroke(Color(ColorConstants.purpleColor), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .glow(color: Color(ColorConstants.purpleColor), radius: 10)
                .animation(.easeIn(duration: 2), value: percentage)
        }
        .overlay {
            ProgressPercentageView(percentage: $percentage)
                .padding([.vertical], Spacings.spacing30)
        }
        
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        @State var percentage: Float = 25.0
        ProgressView(percentage: $percentage)
    }
}
