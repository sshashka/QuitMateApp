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
        VStack {
            AdditionalInfoCell(leadingText: viewModel.dailyData, trailingText: "/ per day")
            AdditionalInfoCell(leadingText: viewModel.weeklyData, trailingText: "/ per week")
            AdditionalInfoCell(leadingText: viewModel.monthlyData, trailingText: "/ per month")
            AdditionalInfoCell(leadingText: viewModel.yearlyData, trailingText: "/ per year")
        }
        .padding(.vertical)
        .frame(maxWidth: .infinity)
    }
}

struct AdditionalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        AdditionalInfoView(viewModel: AdditionalInfoViewModel(value: AdditionalInfoModel(value: 7.0, valueType: .daily)))
    }
}
