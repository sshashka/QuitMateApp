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
                Text(Localizables.activity)
                    .modifier(TextViewModifier(font: .medium, size: 20))
                Text(Localizables.checkMoodsPeriod)
                    .modifier(TextViewModifier(font: .regular, size: 12))
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
        .foregroundColor(Color.labelColor)
//        .padding(.horizontal)
    }
}
//
struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(selectedFilteringMethod: .constant(.oneMonth))
    }
}
