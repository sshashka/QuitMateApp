//
//  AdditionalInfoView.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.07.2023.
//

import SwiftUI

struct AdditionalInfoView: View {
    @EnvironmentObject var viewModel: AdditionalInfoViewModel
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.model, id: \.self) { info in
                    AdditionalInfoCell(image: info.icon, upperText: info.text, bottomText: info.bottomText)
                        .cornerRadius(LayoutConstants.cornerRadius, corners: [.bottomLeft, .bottomRight])
                }
            }.padding(Spacings.spacing15)
            // Because sheet has gray background by default
        }.background(Color(ColorConstants.backgroundColor), ignoresSafeAreaEdges: .all)
    }
}

struct AdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoView()
    }
}
