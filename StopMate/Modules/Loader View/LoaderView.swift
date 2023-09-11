//
//  LoaderView.swift
//  QuitMate
//
//  Created by Саша Василенко on 17.07.2023.
//

import SwiftUI

struct LoaderView: View {
    @State private var value = 0.0
    @State private var text = ""
    @State private var isAnimating = false
    @State private var angle: Angle = .degrees(-90)
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        ZStack(alignment: .center) {
            Text(text)
                .fontStyle(.header)
                .opacity(isAnimating ? 1.0 : 0.0)
                .scaleEffect(isAnimating ? 1.0 : 0.5)
                .animation(.easeInOut(duration: 1.5), value: isAnimating)
                .onAppear {
                    isAnimating = true
                    withAnimation {
                        text = "StopMate"
                    }
                }
            
            Circle()
                .trim(from: 0, to: value)
                .stroke(Color.buttonsPurpleColor, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(angle)
                .animation(.linear, value: angle)
                .glow(color: Color.buttonsPurpleColor, radius: 10)
                .animation(.easeIn, value: value)
                .padding(40)
                .onReceive(timer) { _ in
                    if value <= 0.7 {
                        value += 0.1
                    }
                    angle += .degrees(15)
                }
        }
        .padding(30)
        .ignoresSafeArea()
    }
}


struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
