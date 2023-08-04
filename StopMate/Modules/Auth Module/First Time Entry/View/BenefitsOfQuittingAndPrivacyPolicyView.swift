//
//  BenefitsOfQuittingAndPrivacyPolicyView.swift
//  QuitMate
//
//  Created by Саша Василенко on 03.08.2023.
//

import SwiftUI

struct BenefitsOfQuittingAndPrivacyPolicyView: View {
    var body: some View {
        VStack (alignment: .leading, spacing: Spacings.spacing15) {
            Text("Life without smoking starts now")
                .fontStyle(.header2)
                .foregroundColor(Color(ColorConstants.buttonsColor))
            HStack {
                Image(systemName: "circle.fill")
                    .foregroundColor(.green)
                    .imageScale(.small)
                Text("Improved Mental Health")
                    .fontStyle(.poppinsMedium20)
            }
            Text("Quitting smoking can improve mental health and mood, reducing symptoms of depression and anxiety. It can also boost self-esteem and confidence, leading to a more positive outlook on life")
                .fontStyle(.regularText)
            Text("Better Sleep")
                .fontStyle(.poppinsMedium20)
            Text("Quitting smoking can improve mental health and mood, reducing symptoms of depression and anxiety. It can also boost self-esteem and confidence, leading to a more positive outlook on life")
                .fontStyle(.regularText)
            Text("Improved Social Life")
                .fontStyle(.poppinsMedium20)
            Text("Quitting smoking can improve mental health and mood, reducing symptoms of depression and anxiety. It can also boost self-esteem and confidence, leading to a more positive outlook on life")
                .fontStyle(.regularText)
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct BenefitsOfQuittingAndPrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitsOfQuittingAndPrivacyPolicyView()
    }
}
