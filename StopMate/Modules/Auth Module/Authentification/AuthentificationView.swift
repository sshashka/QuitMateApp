//
//  AuthentificationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.06.2023.
//

import SwiftUI

struct AuthentificationView<ViewModel>: View where ViewModel: AuthentificationViewModelProtocol {
    enum AuthentificationViewFocusFields: Hashable {
        case email
        case password
    }
    @StateObject var viewModel: ViewModel
    @FocusState private var focused: AuthentificationViewFocusFields?
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Log In")
                    .fontStyle(.header)
                Spacer()
            }
            Group {
                ZStack {
                    TextField("", text: $viewModel.email, prompt: Text(Localizables.AuthStrings.email).foregroundColor(Color.black))
                        .padding(.horizontal, Spacings.spacing25)
                        .frame(height: 47)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .focused($focused, equals: .email)
                    RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                        .stroke(lineWidth: 3)
                        .foregroundColor(viewModel.emailTextFieldColor)
                        .frame(height: 47)
                }
                .onTapGesture {
                    // Because of paddings tap area on texfield is much smaller than a view itself
                    focused = .email
                }
                ZStack {
                    SecureField("", text: $viewModel.password, prompt: Text(Localizables.AuthStrings.password).foregroundColor(.black))
                        .padding(.horizontal, Spacings.spacing25)
                        .frame(height: 47)
                        .focused($focused, equals: .password)
                        .submitLabel(.done)
                    RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                        .stroke(lineWidth: 3)
                        .frame(height: 47)
                        .foregroundColor(viewModel.passwordTextFieldColor)
                }
                .onTapGesture {
                    // Because of paddings tap area on texfield is much smaller than a view itself
                    focused = .password
                }
            }
            .onSubmit {
                if viewModel.email.isEmpty {
                    focused = .email
                } else if viewModel.password.isEmpty {
                    focused = .password
                } else {
                    viewModel.didTapOnLogin()
                }
            }
            .fontStyle(.textFieldText)
            .background(Color(ColorConstants.gray))
            .foregroundColor(Color.black)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .cornerRadius(LayoutConstants.cornerRadius, corners: .allCorners)
            
            Button {
                viewModel.didTapOnForgotPassword()
            } label: {
                HStack {
                    Spacer()
                    Text(Localizables.AuthStrings.forgotPassword)
                        .fontStyle(.clearButtonsText)
                }
            }.disabled(viewModel.passwordResetIsEnabled ? false : true)
            
            Button {
                viewModel.didTapOnLogin()
            } label: {
                Text(Localizables.AuthStrings.login)
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.top, Spacings.spacing25)
            .isEnabled(viewModel.loginButtonDisabled)
            
            Spacer()
            
            Button {
                viewModel.didTapOnRegister()
            } label: {
                Text(Localizables.AuthStrings.dontHaveAnAccount)
                    .fontStyle(.clearButtonsText)
            }
        }
        .padding(Spacings.spacing30)
            .overlay {
                if viewModel.state == .loading {
                    CustomProgressView()
                }
            }
            .alert(viewModel.error, isPresented: $viewModel.isShowingAlert) {
                Button("OK") {}
            }
    }
}

struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        let service = FirebaseAuthentificationService()
        @State var mock = AuthentificationViewModel(authentificationService: service)
        AuthentificationView(viewModel: mock)
    }
}
