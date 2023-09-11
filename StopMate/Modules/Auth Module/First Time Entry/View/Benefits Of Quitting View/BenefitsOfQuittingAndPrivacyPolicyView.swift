//
//  BenefitsOfQuittingAndPrivacyPolicyView.swift
//  QuitMate
//
//  Created by Саша Василенко on 03.08.2023.
//

import SwiftUI

struct BenefitsOfQuittingAndPrivacyPolicyView: View {
    let privacyPolicyURL = PrivacyPolicyAndTermsAndConditionsURL.privacyPolicy
    var body: some View {
        VStack (alignment: .leading, spacing: Spacings.spacing15) {
            Spacer()
            Text("Life without smoking starts now")
                .fontStyle(.header2)
                .foregroundColor(Color.buttonsPurpleColor)
            BenefitsOfQuittingView(headerText: "Improved Mental Health", text: "Quitting smoking can improve mental health and mood, reducing symptoms of depression and anxiety.")
            BenefitsOfQuittingView(headerText: "Increased Energy", text: "As your body starts to heal from the damage caused by smoking, you may notice increased energy levels and improved overall vitality.")
            BenefitsOfQuittingView(headerText: "Better Circulation", text: "Your blood circulation improves, leading to warmer hands and feet and a reduced risk of blood clots.")
            Spacer()
            Text("By clicking on finish you agree to the [Privacy policy](https://docs.google.com/document/d/1ww6ypCKPNF8_el1_9nvxhfCwfES6VGBEyNjH9VyookY/edit?usp=sharing) and [Terms and Conditions](https://docs.google.com/document/d/1zMRvkPLOX2DPuYvYnURhzNo5lObr_XMjoZMSUUlkVlU/edit?usp=sharing) ")
                .fontStyle(.greyHeaderText)
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct BenefitsOfQuittingAndPrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitsOfQuittingAndPrivacyPolicyView()
    }
}
