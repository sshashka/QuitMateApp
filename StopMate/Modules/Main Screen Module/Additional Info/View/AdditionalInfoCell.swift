//
//  AdditionalInfoCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import SwiftUI

struct AdditionalInfoCell: View {
//    let image: String
    let leadingText: String
    let trailingText: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                .foregroundStyle(Color.buttonsPurpleColor)
            HStack {
                Text(leadingText)
                Text(trailingText)
            }
            .fontStyle(.regularText)
        }
        .padding(.horizontal)
    }
}

struct AdditionalInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoCell(leadingText: "KEkekke", trailingText: "fdjiofsjodfjiodsfosd")
    }
}
