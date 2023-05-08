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
    var body: some View {
        VStack(alignment: .leading, spacing: Spacings.spacing10) {
            Spacer(minLength: Spacings.spacing10)
            TextView(text: "Quitting information", font: .poppinsSemiBold, size: 16)
                .foregroundColor(.black)
            
            HStack(alignment: .center, spacing: Spacings.spacing10) {
                
                StatsView(titleText: "\(daysFree)", secondaryText: "Days without smoking")
                StatsView(titleText: String(moneySpentOnCigarets) + "$", secondaryText: "Money saved")
                
                
            }.foregroundColor(.black)
            HStack(alignment: .center, spacing: Spacings.spacing10) {
                
                StatsView(titleText: "\(enviromentalChanges)", secondaryText: "Enviromental changes")
                StatsView(titleText: "120", secondaryText: "Days without smoking")
                
                
            }
            .foregroundColor(.black)
            
            Button {
                
            } label: {
                TextView(text: "Reset Progress", font: .poppinsSemiBold, size: 14)
            }
            .buttonStyle(StandartButtonStyle())
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
