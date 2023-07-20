//
//  RegistrationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 19.06.2023.
//

import SwiftUI

struct RegistrationView: View {
    enum RegistrationViewFocusFields: Hashable {
        case email, password, passwordConfirm
    }
    @StateObject var viewModel: RegistrationViewModel
    @FocusState private var focused: RegistrationViewFocusFields?
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextView(text: "Register", font: .poppinsSemiBold, size: 36)
                Spacer()
            }
            
            Group {
                TextField("", text: $viewModel.email, prompt: Text("Email").foregroundColor(.black))
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .focused($focused, equals: .email)
                    .overlay {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .stroke(lineWidth: 1)
                            .foregroundColor($viewModel.emailTextFieldColor.wrappedValue)
                    }
                
                SecureField("", text: $viewModel.password, prompt: Text("Password, at least 8 characters").foregroundColor(.black))
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .focused($focused, equals: .password)
                    .overlay {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .stroke(lineWidth: 1)
                            .foregroundColor($viewModel.passwordTextFieldColor.wrappedValue)
                    }
                
                SecureField("", text: $viewModel.confirmationPassword, prompt: Text("Password confirmation").foregroundColor(.black))
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .focused($focused, equals: .passwordConfirm)
                    .overlay {
                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                            .stroke(lineWidth: 1)
                            .foregroundColor($viewModel.passwordTextFieldColor.wrappedValue)
                    }
            }.onSubmit {
                if viewModel.email.isEmpty {
                    focused = .email
                } else if viewModel.password.isEmpty {
                    focused = .password
                } else if viewModel.confirmationPassword.isEmpty{
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
                TextView(text: "Register", font: .poppinsSemiBold, size: 14)
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.top, Spacings.spacing25)
            .isDisabled(viewModel.registerButtonEnabled)
            Spacer()
            
            Button {
                viewModel.didTapLoginButton()
            } label: {
                TextView(text: "Already have an accout? Log In", font: .poppinsSemiBold, size: 14)
            }
        }
        .overlay {
            if viewModel.state == .loading {
                CustomProgressView()
            }
        }
    
            .padding(Spacings.spacing30)
            .alert($viewModel.error.wrappedValue, isPresented: $viewModel.isShowingAlert) {
                Button("OK") {}
            }
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView(viewModel: RegistrationViewModel(authentificationService: FirebaseAuthentificationService()))
    }
}
