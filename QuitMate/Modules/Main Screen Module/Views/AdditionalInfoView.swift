//
//  AdditionalInfoView.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.07.2023.
//

import SwiftUI

struct AdditionalInfoView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible(minimum: 20.0, maximum: 200.0)), count: 2)
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(1...10, id: \.self) { row in
                    ForEach(1...2, id: \.self) {col in
                        ZStack {
                            RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                                .stroke(style: StrokeStyle(lineWidth: 2))
//                                .padding()
                            VStack {
                                Image("Tokyo")
                                    .resizable()
                                    .frame(maxWidth: 55, maxHeight: 55)
                                Text("You don`t smoke for")
                                Text("55 days")
                            }.padding()
                        }
                        .padding()
                        .id("\(row)\(col)")
                    }
                }
            }
        }
    }
}

struct AdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoView()
    }
}
