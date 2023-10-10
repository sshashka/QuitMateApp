//
//  BenefitsOfQuittingAndPrivacyPolicyView.swift
//  QuitMate
//
//  Created by Саша Василенко on 03.08.2023.
//

import SwiftUI

struct BenefitsOfQuittingAndPrivacyPolicyView: View {
    let privacyPolicyText = Localizables.FirstTimeEntryStrings.privacyPolicy
    var body: some View {
        VStack (alignment: .leading, spacing: Spacings.spacing15) {
            Spacer()
            Text(Localizables.FirstTimeEntryStrings.lifeWithoutSmokingStartsNow)
                .fontStyle(.header2)
                .foregroundColor(Color.buttonsPurpleColor)
            BenefitsOfQuittingView(headerText: Localizables.FirstTimeEntryStrings.improvedMentalHealthHeader, text: Localizables.FirstTimeEntryStrings.improvedMentalHealthText)
            BenefitsOfQuittingView(headerText: Localizables.FirstTimeEntryStrings.increasedEnergyHeader, text: Localizables.FirstTimeEntryStrings.increasedEnergyText)
            BenefitsOfQuittingView(headerText: Localizables.FirstTimeEntryStrings.betterCirculationHeader, text: Localizables.FirstTimeEntryStrings.betterCirculationText)
            Spacer()
            Text("By clicking on finish you agree to the [Privacy policy](https://docs.google.com/document/d/1ww6ypCKPNF8_el1_9nvxhfCwfES6VGBEyNjH9VyookY/edit?usp=sharing) and [Terms and Conditions](https://docs.google.com/document/d/1zMRvkPLOX2DPuYvYnURhzNo5lObr_XMjoZMSUUlkVlU/edit?usp=sharing)")
                .fontStyle(.greyHeaderText)
        }.padding(.horizontal, Spacings.spacing30)
    }
}

struct BenefitsOfQuittingAndPrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        BenefitsOfQuittingAndPrivacyPolicyView()
    }
}
