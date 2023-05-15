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
                TextView(text: TextStringConstants.activity, font: .poppinsMedium, size: 20)
                TextView(text: TextStringConstants.checkYourActivityThroughPeriod, font: .poppinsRegular, size: 12)
            }
            
            .fixedSize()
            Spacer()
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .stroke()
                .overlay {
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
                    }
                }
        }
        .foregroundColor(Color(ColorConstants.labelColor))
        .padding(.leading)
    }
}
//
struct FilterMenuView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMenuView(selectedFilteringMethod: .constant(.oneMonth))
    }
}
