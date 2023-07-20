//
//  RegistrationUserView.swift
//  QuitMate
//
//  Created by Саша Василенко on 12.06.2023.
//

import SwiftUI

struct FirstTimeEntryView: View {
    enum Field: Hashable {
        case name, age, startingDate, finishingDate, money
    }
    @StateObject var viewModel: FirstTimeEntryViewModel
    @State private var isShowingCurrencyPicker: Bool = false
    @State private var selectedField: Field = .name
    @FocusState private var focusedField: Field?
    var body: some View {
        VStack {
            TabView(selection: $selectedField) {
                TextFieldWithUnderlineView(headerText: "What should we call you?", text: $viewModel.name, placeHolderText: "Your name")
                    .focused($focusedField, equals: .name)
                    .tag(Field.name)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = selectedField
                        }
                    }
                TextFieldWithUnderlineView(headerText: "How old are you?", text: $viewModel.age ,placeHolderText: "Your age")
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: .age)
                    .tag(Field.age)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            focusedField = selectedField
                        }
                    }
                PeriodOfTimeToQuitView(period: .startingDate, headerText: "When did u start quitting process?", datePickerText: "Starting date", date: $viewModel.startingDate)
                    .tag(Field.startingDate)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { focusedField = nil
                        }
                    }
                PeriodOfTimeToQuitView(period: .finishingDate, headerText: "When do you want to finish?", datePickerText: "Finishing date", date: $viewModel.finishingDate)
                    .tag(Field.finishingDate)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { focusedField = nil
                        }
                    }
                
                    // Add support for changing currency
                    TextFieldWithUnderlineView(headerText: "How much money do you spend on cigarets daily?", text: $viewModel.moneySpendOnSmoking, placeHolderText: "Amount")
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: .money)
                        .tag(Field.money)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                focusedField = selectedField
                            }
                        }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeOut(duration: 0.4), value: selectedField)
            Button {
                switch selectedField {
                case .name:
                    selectedField = .age
                case .age:
                    selectedField = .startingDate
                case .startingDate:
                    selectedField = .finishingDate
                case .finishingDate:
                    selectedField = .money
                case .money:
                    viewModel.didTapOnFinish()
                }
            } label: {
                Text(selectedField == .money ? "Finish" : "Next")
            }
            .buttonStyle(StandartButtonStyle())
            .padding(Spacings.spacing30)
            
            if isShowingCurrencyPicker {
                CurrencyPicker()
                    .transition(.move(edge: .bottom))
                    .animation(.spring(), value: isShowingCurrencyPicker)
            }
        }
    }
}

struct RegistrationUserView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeEntryView(viewModel: FirstTimeEntryViewModel(authService: FirebaseStorageService()))
    }
}
