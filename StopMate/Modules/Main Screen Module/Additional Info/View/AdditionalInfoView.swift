//
//  AdditionalInfoView.swift
//  QuitMate
//
//  Created by Саша Василенко on 18.07.2023.
//

import SwiftUI

struct AdditionalInfoView<ViewModel>: View where ViewModel: AddAdditionalInfoViewModelProtocol {
    @StateObject var viewModel: ViewModel
    var body: some View {
        VStack(spacing: Spacings.spacing10) {
            Text(viewModel.headerText)
                .fontStyle(.header2)
                .minimumScaleFactor(0.6)
            Text(viewModel.explanatoryText)
                .fontStyle(.greyHeaderText)
                .foregroundColor(.gray)
                .minimumScaleFactor(0.6)
            Spacer()
            AdditionalInfoCell(leadingText: viewModel.dailyData, trailingText: "/ \(Localizables.day)")
            AdditionalInfoCell(leadingText: viewModel.weeklyData, trailingText: "/ \(Localizables.week)")
            AdditionalInfoCell(leadingText: viewModel.monthlyData, trailingText: "/ \(Localizables.month)")
            AdditionalInfoCell(leadingText: viewModel.yearlyData, trailingText: "/ \(Localizables.year)")
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}

struct AdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoView(viewModel: AdditionalInfoViewModel(value: AdditionalInfoModel(value: 7.0, valueType: .daily, valueUnit: .money("$")), headerText: "Money", explanatoryText: "This is explanation it can take smth aroud 3 lines or less"))
    }
}
