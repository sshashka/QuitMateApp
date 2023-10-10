//
//  RegistrationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.06.2023.
//

import SwiftUI

struct RegistrationView<ViewModel>: View where ViewModel: RegistrationViewModelProtocol {
    enum RegistrationViewFocusFields: Hashable {
        case email, password, passwordConfirm
    }
    @StateObject var viewModel: ViewModel
    @FocusState private var focused: RegistrationViewFocusFields?
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(Localizables.AuthStrings.register)
                    .fontStyle(.header)
                Spacer()
            }
            
            Group {
                TextField("", text: $viewModel.email, prompt: Text(Localizables.AuthStrings.email).foregroundColor(.black))
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .focused($focused, equals: .email)
                    .overlay {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundColor(viewModel.emailTextFieldColor)
                    }
                
                SecureField("", text: $viewModel.password, prompt: Text(Localizables.AuthStrings.passwordEightCharacters).foregroundColor(.black))
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .focused($focused, equals: .password)
                    .overlay {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundColor(viewModel.passwordTextFieldColor)
                    }
                
                SecureField("", text: $viewModel.passwordConfirmation, prompt: Text(Localizables.AuthStrings.passwordConfirm).foregroundColor(.black))
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .focused($focused, equals: .passwordConfirm)
                    .overlay {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .stroke(lineWidth: 3)
                            .foregroundColor(viewModel.passwordConfirmationTextFieldColor)
                    }
            }.onSubmit {
                if viewModel.email.isEmpty {
                    focused = .email
                } else if viewModel.password.isEmpty {
                    focused = .password
                } else if viewModel.passwordConfirmation.isEmpty{
                    focused = .passwordConfirm
                } else {
                    viewModel.didTapDoneButton()
                }
            }
            .fontStyle(.textFieldText)
            .background(Color(ColorConstants.gray))
            .foregroundColor(Color.black)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .cornerRadius(LayoutConstants.cornerRadius, corners: .allCorners)
            Button {
                viewModel.didTapDoneButton()
            } label: {
                Text(Localizables.AuthStrings.register)
                    .fontStyle(.clearButtonsText)
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.top, Spacings.spacing25)
            .isEnabled(viewModel.registerButtonEnabled)
            Spacer()
            
            Button {
                viewModel.didTapLoginButton()
            } label: {
                Text(Localizables.AuthStrings.alreadyHaveAnAccount)
                    .fontStyle(.clearButtonsText)
            }
        }
        .overlay {
            if viewModel.state == .loading {
                CustomProgressView()
            }
        }
        .padding(Spacings.spacing30)
        .alert(viewModel.error, isPresented: $viewModel.isShowingAlert) {
            Button("OK") {}
        }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: RegistrationViewModel(authentificationService: FirebaseAuthentificationService()))
    }
}
