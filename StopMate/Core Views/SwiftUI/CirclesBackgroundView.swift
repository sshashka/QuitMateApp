//
//  MilestoneCompletedView.swift
//  StopMate
//
//  Created by Саша Василенко on 16.10.2023.
//

import SwiftUI

struct CirclesBackgroundView: View {
    private let circleSize: CGFloat = 120
    @State private var animationVariable = 0
    private let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader { proxy in
            ForEach(0...5, id:\.self) { index in
                MainCircleView(percentage: Double.random(in: 0.6...0.9))
                    .rotationEffect(.degrees(Double.random(in: 0...360)))
                    .offset(x: CGFloat.random(in: 0.0...proxy.size.width) - circleSize, y: CGFloat.random(in: 0.0...proxy.size.height))
                    .animation(.easeInOut(duration: 4), value: animationVariable)
                    .frame(width: circleSize, height: circleSize)
            }
        }
        .opacity(0.8)
        .blur(radius: 0.8)
        .onReceive(timer, perform: { _ in
            animationVariable = Int.random(in: Int.min...Int.max)
        })
    }
}

#Preview {
    CirclesBackgroundView()
}
