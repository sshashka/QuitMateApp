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
            Spacer()
            Text("Life without smoking starts now")
                .fontStyle(.header2)
                .foregroundColor(Color(ColorConstants.buttonsColor))
            BenefitsOfQuittingView(headerText: "Improved Mental Health", text: "Quitting smoking can improve mental health and mood, reducing symptoms of depression and anxiety.")
            BenefitsOfQuittingView(headerText: "Increased Energy", text: "As your body starts to heal from the damage caused by smoking, you may notice increased energy levels and improved overall vitality.")
            BenefitsOfQuittingView(headerText: "Better Circulation", text: "Your blood circulation improves, leading to warmer hands and feet and a reduced risk of blood clots.")
            Spacer()
            // TODO: Set url to real provacy policy
            Text("By clicking on finish you agree to the [Privacy policy](\(PrivacyPolicyAndTermsAndConditionsURL.privacyPolicy)) and [Terms and Conditions](\(PrivacyPolicyAndTermsAndConditionsURL.termsAndConditions))")
                .fontStyle(.greyHeaderText)
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct BenefitsOfQuittingAndPrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitsOfQuittingAndPrivacyPolicyView()
    }
}
