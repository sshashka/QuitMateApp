//
//  QuittingInformationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI

struct QuittingInformationView: View {
    @Binding var moneySpentOnCigarets: Double
    @Binding var daysFree: Int
    @Binding var enviromentalChanges: Int
    @Binding var daysToFinish: String
    
    @Binding var userConfirmedReset: Bool
    @State private var resetButtonPressed: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: Spacings.spacing10) {
            Spacer(minLength: Spacings.spacing10)
            TextView(text: "Quitting information", font: .poppinsSemiBold, size: 16)
                .foregroundColor(.black)
            
            HStack(alignment: .center, spacing: Spacings.spacing10) {
                StatsView(image: IconConstants.noSmoking, titleText: "\(daysFree)", secondaryText: "Days without smoking", tintColor: .blue)
                StatsView(image: IconConstants.money, titleText: String(moneySpentOnCigarets) + "$", secondaryText: "Money saved", tintColor: .green)
            }.foregroundColor(.black)
            HStack(alignment: .center, spacing: Spacings.spacing10) {
                StatsView(image: IconConstants.earth, titleText: "\(enviromentalChanges)", secondaryText: "Enviromental changes", tintColor: .green)
                StatsView(image: IconConstants.moon,titleText: daysToFinish, secondaryText: "Days to finish", tintColor: .mint)
            }
            .foregroundColor(.black)
            
            Button {
                resetButtonPressed.toggle()
            } label: {
                TextView(text: "Reset Progress", font: .poppinsSemiBold, size: 14)
            }
            .buttonStyle(StandartButtonStyle())
            .alert("Do you want to reset timer? (note: this operation cannot be undone)", isPresented: $resetButtonPressed) {
                Button("Cancel", role: .cancel) {
                    resetButtonPressed.toggle()
                }
                Button("Yes", role: .destructive) {
                    userConfirmedReset.toggle()
                }
            }
            Spacer(minLength: Spacings.spacing10)
        }
        .padding([.horizontal], 30)
    }
}

//struct QuittingInformationView_Previews: PreviewProvider {
//    @State var mockDataForSigarets = 0.0
//    static var previews: some View {
//        QuittingInformationView(moneySpentOnCigarets: $mockDataForSigarets)
//    }
//}
