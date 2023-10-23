//
//  ProgressView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct UserProgressView: View {
//    @State var isLoading: Bool
    var percentage: Double
    var body: some View {
        MainCircleView(percentage: percentage)
            .overlay {
                ProgressPercentageView(percentage: percentage)
                    .padding(.vertical, Spacings.spacing30)
            }
    }
}


struct ProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let percentage: Double = 0.05
        UserProgressView(percentage: percentage)
    }
}
