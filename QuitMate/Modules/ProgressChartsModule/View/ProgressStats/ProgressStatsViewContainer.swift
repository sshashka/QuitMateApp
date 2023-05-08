//
//  ProgressStatsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI

struct ProgressStatsViewContainer: View {
    @Binding var bestDay: String
    @Binding var worstDay: String
    @Binding var bestScore: String
    @Binding var worstScore: String
    var body: some View {
        HStack (alignment: .top) {
            VStack(alignment: .leading, spacing: Spacings.spacing15) {
                ProgressStatsView(titleText: "Best day", secondaryText: bestDay)
                ProgressStatsView(titleText: "Best score", secondaryText: bestScore)
                ProgressStatsView(titleText: "Wiii", secondaryText: "Character #1")
            }
            Spacer()
            VStack(alignment: .leading, spacing: Spacings.spacing15) {
                ProgressStatsView(titleText: "Worst day", secondaryText: worstDay)
                ProgressStatsView(titleText: "Worst score", secondaryText: worstScore)
            }
        }
        .padding(Spacings.spacing20)
        
    }
}

struct ProgressStatsViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        
        ProgressStatsViewContainer(bestDay: .constant("54"), worstDay: .constant("R3e"), bestScore: .constant("333"), worstScore: .constant("e332423"))
    }
}
