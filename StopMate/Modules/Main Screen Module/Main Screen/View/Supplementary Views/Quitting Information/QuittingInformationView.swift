//
//  QuittingInformationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 24.04.2023.
//

import SwiftUI
import SkeletonUI

struct QuittingInformationView: View {
    @EnvironmentObject var vm: MainScreenViewModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(Localizables.quittingInformation)
                .fontStyle(.customSemibold16)
            
                HStack(alignment: .center) {
                    StatsView(image: IconConstants.noSmoking, titleText: vm.daysWithoutSmoking,
                              secondaryText: Localizables.daysWithoutSmoking, tintColor: .blue)
                    Spacer()
                    StatsView(image: IconConstants.money, titleText: vm.moneySaved,
                              secondaryText: Localizables.moneySaved, tintColor: .green)
                    .onTapGesture {
                        vm.didTapOnAdditionalStats(type: .money)
                    }
                }.skeleton(with: vm.state == .loading)
            
                HStack(alignment: .center) {
                    StatsView(image: IconConstants.earth, titleText: vm.emissions,
                              secondaryText: Localizables.unrealeasedChemichals, tintColor: .green)
                    .onTapGesture {
                        vm.didTapOnAdditionalStats(type: .enviroment)
                    }
                    Spacer()
                    StatsView(image: IconConstants.finish,titleText: vm.daysToFinish,
                              secondaryText: Localizables.daysToFinish, tintColor: nil)
                }
            
        }
    }
}

struct QuittingInformationView_Previews: PreviewProvider {
    static var previews: some View {
        QuittingInformationView()
    }
}
