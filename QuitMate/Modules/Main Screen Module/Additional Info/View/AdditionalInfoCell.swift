//
//  AdditionalInfoCell.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.07.2023.
//

import SwiftUI

struct AdditionalInfoCell: View {
    var body: some View {
        GroupBox {
            HStack {
                Image("Tokyo")
                    .resizable()
                    .clipShape(Rectangle())
                    .frame(width: 55, height: 55)
                VStack {
                    Text("Henlo")
                    Text("You don`t smoke for 55 days already")
                }
            }
        }
    }
}

struct AdditionalInfoCell_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoCell()
    }
}
