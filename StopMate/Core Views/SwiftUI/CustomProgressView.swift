//
//  CustomProgressView.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.07.2023.
//

import SwiftUI

struct CustomProgressView: View {
    @State private var offset = UIScreen.main.bounds.height
    var body: some View {
        GroupBox {
            ProgressView()
                .padding(Spacings.spacing40)
        }
        .opacity(0.9)
        .offset(y: offset)
        .animation(.easeIn(duration: 0.7), value: offset)
        .onAppear {
            offset = 0
        }
        .onDisappear {
            offset = UIScreen.main.bounds.height
        }
        .zIndex(0)
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView()
    }
}
