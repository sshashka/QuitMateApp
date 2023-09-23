//
//  CorrelationView.swift
//  StopMate
//
//  Created by Саша Василенко on 09.09.2023.
//

import SwiftUI

struct CorrelationView: View {
    var correlation: Double
    var body: some View {
        HStack {
            ZStack {
                GeometryReader { proxy in
                    ZStack(alignment: .bottom) {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .foregroundColor(.buttonsPurpleColor)
                            .frame(width: proxy.size.width, height: CGFloat((correlation + 1) / 2) * proxy.size.height)
                        ZStack {
                            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                                .stroke(lineWidth: 5)
                                .foregroundColor(.labelColor)
                            
                        }
                    }
                }
                Text(String(format: "%.2f", correlation))
                    .fontStyle(.header)
                    .foregroundColor(.labelColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                    .padding(.horizontal, Spacings.spacing5)
            }
            VStack {
                Text("1")
                Spacer()
                Text("0")
                Spacer()
                Text("-1")
            }.fontStyle(.regularText)
        }
        .padding()
    }
}

struct CorrelationView_Previews: PreviewProvider {
    static var previews: some View {
        CorrelationView(correlation: -1.0)
    }
}
