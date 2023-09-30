//
//  BenefitsOfQuittingView.swift
//  StopMate
//
//  Created by Саша Василенко on 10.08.2023.
//

import SwiftUI

struct BenefitsOfQuittingView: View {
    let headerText: String
    let text: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "circle.fill")
                    .imageScale(.small)
                    .foregroundColor(.green)
                Text(headerText)
                    .fontStyle(.customMedium20)
                    .minimumScaleFactor(0.7)
            }
            Text(text)
                .fontStyle(.regularText)
                .minimumScaleFactor(0.7)
        }
    }
}

struct BenefitsOfQuittingView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitsOfQuittingView(headerText: "Improved Mental Health", text: "Quitting smoking can improve mental health and mood, reducing symptoms of depression and anxiety. It can also boost self-esteem and confidence, leading to a more positive outlook on life")
    }
}
