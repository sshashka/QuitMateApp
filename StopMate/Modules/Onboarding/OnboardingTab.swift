//
//  OnboardingTab.swift
//  StopMate
//
//  Created by Саша Василенко on 15.08.2023.
//

import SwiftUI

struct OnboardingTab: View {
    let headerText: String
    let icon: String?
    let systemIcon: String?
    let description: String
    var body: some View {
        VStack(spacing: Spacings.spacing15) {
            Text(headerText)
                .fontStyle(.header2)
            if let icon {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 155, maxHeight: 155)
            }
            if let systemIcon {
                Image(systemName: systemIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 155, height: 155)
            }
            Text(description)
                .fontStyle(.regularText)
        }.padding(Spacings.spacing30)
    }
}

struct OnboardingTab_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingTab(headerText: "Header!", icon: "Tweak", systemIcon: nil, description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
    }
}
