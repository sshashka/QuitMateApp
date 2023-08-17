//
//  RegistrationUserView.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.06.2023.
//

import SwiftUI

struct FirstTimeEntryView<ViewModel>: View where ViewModel: FirstTimeEntryViewModelProtocol {
    enum Field: Hashable {
        case name, age, startingDate, finishingDate, money, privacyPolicy
    }
    @StateObject var viewModel: ViewModel
    @State private var isShowingCurrencyPicker: Bool = false
    @State private var selectedField: Field = .name
    @FocusState private var focusedField: Field?
    var body: some View {
        VStack {
            TabView(selection: $selectedField) {
                TextFieldWithUnderlineViewAndHeader(headerText: AuthModuleStrings.whatIsYourName, text: $viewModel.name, placeHolderText: AuthModuleStrings.yourName)
                    .focused($focusedField, equals: .name)
                    .tag(Field.name)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = selectedField
                        }
                    }
                TextFieldWithUnderlineViewAndHeader(headerText: AuthModuleStrings
                    .howOldAreYou, text: $viewModel.age ,placeHolderText: AuthModuleStrings.yourAge)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .age)
                    .tag(Field.age)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = selectedField
                        }
                    }
                
                //TODO: Add support for changing currency
                CurrencyPicker(selection: $viewModel.currency, text: $viewModel.moneySpendOnSmoking, placeHolderText: AuthModuleStrings.amount, headerText: AuthModuleStrings.amountOfMoney)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .money)
                    .tag(Field.money)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = selectedField
                        }
                    }
    
                PeriodOfTimeToQuitView(period: .startingDate, headerText: AuthModuleStrings.startedSmoking, datePickerText: AuthModuleStrings.startingDate, date: $viewModel.startingDate)
                    .tag(Field.startingDate)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = nil
                        }
                    }
                PeriodOfTimeToQuitView(period: .finishingDate, headerText: AuthModuleStrings.finishSmoking, datePickerText: AuthModuleStrings.finishingDate, date: $viewModel.finishingDate)
                    .tag(Field.finishingDate)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = nil
                        }
                    }
                
                BenefitsOfQuittingAndPrivacyPolicyView()
                    .tag(Field.privacyPolicy)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeOut(duration: 0.4), value: selectedField)
            Button {
                switch selectedField {
                case .name:
                    selectedField = .age
                case .age:
                    selectedField = .money
                case .money:
                    selectedField = .startingDate
                case .startingDate:
                    selectedField = .finishingDate
                case .finishingDate:
                    selectedField = .privacyPolicy
                case .privacyPolicy:
                    viewModel.didTapOnFinish()
                }
            } label: {
                Text(selectedField == .privacyPolicy ? "Finish" : "Next")
            }
            .buttonStyle(StandartButtonStyle())
            .padding(Spacings.spacing30)
        }
    }
}

struct RegistrationUserView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeEntryView(viewModel: FirstTimeEntryViewModel(storageService: FirebaseStorageService()))
    }
}
