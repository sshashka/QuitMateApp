//
//  HeadingView.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.04.2023.
//

import SwiftUI

struct HeaderView: View {
    let dateInString: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Quitting Analysis")
                    .modifier(TextViewModifier(font: .poppinsSemiBold, size: 18))
                Text(dateInString)
                    .modifier(TextViewModifier(font: .poppinsMedium, size: 14))
            }
            Spacer()
        }
        .padding([.horizontal])
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDate = "May 10, 2023"
        HeaderView(dateInString: mockDate)
    }
}
