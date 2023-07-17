//
//  LoaderView.swift
//  QuitMate
//
//  Created by Саша Василенко on 17.07.2023.
//

import SwiftUI

struct LoaderView: View {
    private let value = 1
    var body: some View {
        ZStack(alignment: .center) {
            Text("SM")
                .transition(.opacity)
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color(ColorConstants.buttonsColor), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .glow(color: Color(ColorConstants.buttonsColor), radius: 10)
                .animation(.easeIn(duration: 2), value: value)
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
