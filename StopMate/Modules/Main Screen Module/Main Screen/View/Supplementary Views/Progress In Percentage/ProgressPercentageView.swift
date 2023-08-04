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
                    Text("Progress")
                        .modifier(TextViewModifier(font: .poppinsMedium, size: 18))
                    Text("\(Int(percentage * 100))")
                        .modifier(TextViewModifier(font: .poppinsBlack, size: 48))
                    Text("%")
                        .modifier(TextViewModifier(font: .poppinsMedium, size: 18))
                }
                .minimumScaleFactor(0.6)
            }
        }
    }
}


