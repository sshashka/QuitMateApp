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

    var body: some View {
        ZStack(alignment: .center) {
            Text(text)
                .font(.largeTitle)
                .foregroundColor(.white)
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
                .stroke(Color(ColorConstants.buttonsColor), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .glow(color: Color(ColorConstants.buttonsColor), radius: 10)
                .animation(.easeIn(duration: 1.5), value: value)
                .padding(40)
                .onAppear {
                    value = 1.0
                }
        }
        .padding(30)
        .background(Color.black)
        .ignoresSafeArea()
    }
}


struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
