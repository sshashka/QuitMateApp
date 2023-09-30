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
            Text(Localizables.lifeWithoutSmokingStartsNow)
                .fontStyle(.header2)
                .foregroundColor(Color.buttonsPurpleColor)
            BenefitsOfQuittingView(headerText: Localizables.improvedMentalHealthHeader, text: Localizables.improvedMentalHealthText)
            BenefitsOfQuittingView(headerText: Localizables.increasedEnergyHeader, text: Localizables.increasedEnergyText)
            BenefitsOfQuittingView(headerText: Localizables.betterCirculationHeader, text: Localizables.betterCirculationText)
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
