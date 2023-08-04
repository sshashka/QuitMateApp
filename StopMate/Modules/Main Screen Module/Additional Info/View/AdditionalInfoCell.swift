//
//  AdditionalInfoCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import SwiftUI

struct AdditionalInfoCell: View {
    let image: String
    let upperText: String
    let bottomText: String
    var body: some View {
        GroupBox {
            HStack {
                Image(image)
                    .resizable()
                    .clipShape(Rectangle())
                    .frame(width: 55, height: 55)
                    .foregroundColor(Color(ColorConstants.labelColor))
                VStack(alignment: .leading) {
                    Text(upperText)
                    Text(bottomText)
                }.padding()
            }
        }.frame(maxWidth: .infinity)
    }
}

struct AdditionalInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoCell(image: IconConstants.danger, upperText: "dfsds", bottomText: "fdssdfsfsdf")
    }
}
