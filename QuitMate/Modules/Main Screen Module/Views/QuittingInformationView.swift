//
//  QuittingInformationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct QuittingInformationView: View {
    // All strings?
    let moneySpentOnCigarets: Double
    let daysWithoutSmoking: Int
    let enviromentalChanges: Int
    let daysToFinish: String
    var body: some View {
        
        VStack(alignment: .leading, spacing: Spacings.spacing10) {
            Spacer()
            Text("Quitting information")
                .fontStyle(.poppinsSemibold16)
            HStack(alignment: .center, spacing: Spacings.spacing10) {
                StatsView(image: IconConstants.noSmoking, titleText: "\(daysWithoutSmoking)", secondaryText: "Days without smoking", tintColor: .blue)
                StatsView(image: IconConstants.money, titleText: String(moneySpentOnCigarets) + "$", secondaryText: "Money saved", tintColor: .green)
            }
            
            HStack(alignment: .center, spacing: Spacings.spacing10) {
                StatsView(image: IconConstants.earth, titleText: "\(enviromentalChanges)", secondaryText: "Enviromental changes", tintColor: .green)
                StatsView(image: IconConstants.finish,titleText: daysToFinish, secondaryText: "Days to finish", tintColor: nil)
            }
            
        }
    }
}

struct QuittingInformationView_Previews: PreviewProvider {
    static var previews: some View {
        @State var confirmedReset = false
        QuittingInformationView(moneySpentOnCigarets: 0.0, daysWithoutSmoking: 0, enviromentalChanges: 0, daysToFinish: "0")
    }
}
