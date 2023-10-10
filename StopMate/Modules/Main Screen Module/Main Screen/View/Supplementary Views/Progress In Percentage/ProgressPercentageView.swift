//
//  ProgressPercentageView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct ProgressPercentageView: View {
    var percentage: Double
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: Spacings.spacing10) {
                Group {
                    Text(Localizables.MainScreen.progress)
                        .modifier(TextViewModifier(font: .medium, size: 18))
                    Text("\(Int(percentage * 100))")
//                    Text(String(percentage.formatted(.percent)))
                        .modifier(TextViewModifier(font: .black, size: 48))
                    Text("%")
                        .modifier(TextViewModifier(font: .medium, size: 18))
                }
                .minimumScaleFactor(0.6)
            }
        }
    }
}


