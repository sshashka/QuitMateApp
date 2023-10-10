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
                Text(Localizables.ChartsStrings.activity)
                    .modifier(TextViewModifier(font: .medium, size: 20))
                Text(Localizables.ChartsStrings.checkMoodsPeriod)
                    .modifier(TextViewModifier(font: .regular, size: 12))
                    .fixedSize()
            }
            Spacer()
            ZStack {
                Menu {
                    Button(ProgressChartsPeriods.twoWeeks.localizedCase, action: {
                        selectedFilteringMethod = .twoWeeks
                    })
                    Button(ProgressChartsPeriods.oneMonth.localizedCase, action: {
                        selectedFilteringMethod = .oneMonth
                    })
                    Button(ProgressChartsPeriods.threeMonth.localizedCase) {
                        selectedFilteringMethod = .threeMonth
                    }
                } label: {
                    Text(selectedFilteringMethod.localizedCase)
                    // Fixes text being trunkated when changes occur
                        .fixedSize()
                }
                .padding()
                RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                    .stroke()
            }
        }
        .foregroundColor(Color.labelColor)
    }
}

struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(selectedFilteringMethod: .constant(.oneMonth))
    }
}
