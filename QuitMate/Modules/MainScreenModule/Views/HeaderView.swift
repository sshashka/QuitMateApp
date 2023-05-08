//
//  HeadingView.swift
//  QuitMate
//
//  Created by Саша Василенко on 25.04.2023.
//

import SwiftUI

struct HeaderView: View {
    @Binding var dateInString: String
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                TextView(text: "Quitting Analysis", font:  .poppinsSemiBold, size: 18)
                TextView(text: dateInString, font:  .poppinsMedium, size: 14)
            }
            Spacer()
        }
        .padding([.horizontal])
    }
}

struct HeadingView_Previews: PreviewProvider {
    static var previews: some View {
        @State var mockDate = "May 10, 2023"
        HeaderView(dateInString: $mockDate)
    }
}
