//
//  MilestoneCompletedView.swift
//  StopMate
//
//  Created by Саша Василенко on 16.10.2023.
//

import SwiftUI

struct MilestoneCompletedView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text(Localizables.MilestoneCompletedStrings.header)
                    .fontStyle(.header)
                Text(Localizables.MilestoneCompletedStrings.bottomText)
                    .fontStyle(.regularText)
                Button {
                    
                } label: {
                    Text(Localizables.MilestoneCompletedStrings.continueUsingAsDiary)
                }
                
                Button {
                    
                } label: {
                    Text(Localizables.MilestoneCompletedStrings.setANewDate)
                }

            }
            .buttonStyle(StandartButtonStyle())
            .padding(Spacings.spacing30)
        }
        .background(CirclesBackgroundView().opacity(0.6))
    }
}

#Preview {
    MilestoneCompletedView()
}
