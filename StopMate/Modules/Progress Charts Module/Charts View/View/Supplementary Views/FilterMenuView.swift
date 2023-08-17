//
//  FilterMenuView.swift
//  QuitMate
//
//  Created by Саша Василенко on 03.05.2023.
//

import SwiftUI

struct FilterMenuView: View {
    @Binding var selectedFilteringMethod: ProgressChartsPeriods
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(TextStringConstants.activity)
                    .modifier(TextViewModifier(font: .poppinsMedium, size: 20))
                Text(TextStringConstants.checkYourActivityThroughPeriod)
                    .modifier(TextViewModifier(font: .poppinsRegular, size: 12))
                    .fixedSize()
            }
            Spacer()
            ZStack {
                Menu {
                    Button("2 Weeks", action: {
                        selectedFilteringMethod = .twoWeeks
                    })
                    Button("1 Month", action: {
                        selectedFilteringMethod = .oneMonth
                    })
                    Button("3 Months") {
                        selectedFilteringMethod = .threeMonth
                    }
                } label: {
                    Text(selectedFilteringMethod.rawValue)
                    // Fixes text being trunkated when changes occur
                        .fixedSize()
                }
//                .fixedSize()
                .padding()
                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                    .stroke()
            }
        }
        .foregroundColor(Color(ColorConstants.labelColor))
//        .padding(.horizontal)
    }
}
//
struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(selectedFilteringMethod: .constant(.oneMonth))
    }
}
