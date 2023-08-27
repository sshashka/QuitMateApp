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
            Text("Quitting information")
                .fontStyle(.poppinsSemibold16)
            HStack(alignment: .center) {
                StatsView(image: IconConstants.noSmoking, titleText: "\(vm.daysWithoutSmoking)", secondaryText: "Days without smoking", tintColor: .blue)
                StatsView(image: IconConstants.money, titleText: vm.moneySaved, secondaryText: "Money saved", tintColor: .green)
            }.skeleton(with: vm.state == .loading)
            HStack(alignment: .center) {
                StatsView(image: IconConstants.earth, titleText: vm.emissions, secondaryText: "Of unreleased chemicals", tintColor: .green)
                StatsView(image: IconConstants.finish,titleText: vm.daysToFinish, secondaryText: "Days to finish", tintColor: nil)
            }.skeleton(with: vm.state == .loading)
        }
    }
}

struct QuittingInformationView_Previews: PreviewProvider {
    static var previews: some View {
//        @State var confirmedReset = false
        QuittingInformationView()
    }
}
