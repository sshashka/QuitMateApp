//
//  ProgressStatsView.swift
//  QuitMate
//
//  Created by Саша Василенко on 04.05.2023.
//

import SwiftUI

struct ProgressStatsViewContainer: View {
    var bestDay: String
    var worstDay: String
    var bestScore: String
    var worstScore: String
    var body: some View {
        HStack (alignment: .top) {
            VStack(alignment: .leading, spacing: Spacings.spacing15) {
                ProgressStatsView(titleText: "Best day", secondaryText: bestDay)
                ProgressStatsView(titleText: "Best score", secondaryText: bestScore)
                //                ProgressStatsView(titleText: "Wiii", secondaryText: "Character #1")
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
        ProgressStatsViewContainer(bestDay: "54", worstDay: "R3e", bestScore: "333", worstScore: "e332423")
    }
}
