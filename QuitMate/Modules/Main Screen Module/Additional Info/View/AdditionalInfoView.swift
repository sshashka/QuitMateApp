//
//  AdditionalInfoView.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.07.2023.
//

import SwiftUI

struct AdditionalInfoView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<19) { id in
                    AdditionalInfoCell()
                        .cornerRadius(LayoutConstants.cornerRadius, corners: [.bottomLeft, .bottomRight])
                }
            }.padding(.horizontal, Spacings.spacing10)
        }
    }
}

struct AdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoView()
    }
}
