//
//  MainCircleView.swift
//  StopMate
//
//  Created by Саша Василенко on 16.10.2023.
//

import SwiftUI

struct MainCircleView: View {
    var percentage: Double
    var body: some View {
        Circle()
            .trim(from: 0, to: CGFloat(percentage))
            .stroke(Color.buttonsPurpleColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .rotationEffect(Angle(degrees: -90))
            .glow(color: Color.buttonsPurpleColor, radius: 10)
            .animation(.easeIn(duration: 2), value: percentage)
    }
}

#Preview {
    MainCircleView(percentage: 0.5)
}
