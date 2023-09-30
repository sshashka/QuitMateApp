//
//  SmokeUrgeButtonGrid.swift
//  StopMate
//
//  Created by Саша Василенко on 29.08.2023.
//

import SwiftUI

struct SmokeUrgeButtonGrid: View {
    @Binding var selection: Int?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(1...10, id: \.self) { value in
                    Button {
                        selection = value
                    } label: {
                        Text("\(value)")
                    }
                    .buttonStyle(ButtonInGridButtonStyle())
                    .overlay {
                        if value == selection {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Color.buttonsPurpleColor)
                                .colorMultiply(Color.buttonsPurpleColor)
                                .opacity(0.4)
                        }
                    }
                }.fixedSize()
            }
        }
    }
}

struct SmokeUrgeButtonGrid_Previews: PreviewProvider {
    static var previews: some View {
        @State var selection: Int? = 5
        SmokeUrgeButtonGrid(selection: $selection)
    }
}
