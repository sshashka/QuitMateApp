//
//  ProgressPercentageView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct ProgressPercentageView: View {
    @Binding var percentage: Float
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: Spacings.spacing10) {
                Group {
                    Text("Progress")
                        .font(.custom("Poppins-Medium", size: 18))
                    Text("\(Int(percentage * 100))")
                        .font(.custom("Poppins-Black", size: 48))
                    Text("%")
                        .font(.custom("Poppins-Medium", size: 18))
                }
                .minimumScaleFactor(0.6)
            }
        }
    }
}


