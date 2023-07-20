//
//  AuthentificationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.06.2023.
//

import SwiftUI

struct AuthentificationView: View {
    enum AuthentificationViewFocusFields: Hashable {
        case email
        case password
    }
    @StateObject var viewModel: AuthentificationViewModel
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
                    TextField("", text: $viewModel.email, prompt: Text("Email").foregroundColor(Color.black))
                        .padding(.horizontal, Spacings.spacing25)
                        .frame(height: 47)
                        .keyboardType(.emailAddress)
                        .submitLabel(.next)
                        .focused($focused, equals: .email)
                    RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                        .stroke(lineWidth: 1)
                        .foregroundColor($viewModel.emailTextFieldColor.wrappedValue)
                        .frame(height: 47)
                }
                .onTapGesture {
                    // Because of paddings tap area on texfield is much smaller than a view itself
                    focused = .email
                }
                ZStack {
                    SecureField("", text: $viewModel.password, prompt: Text("Password, at least 8 characters").foregroundColor(.black))
                        .padding(.horizontal, Spacings.spacing25)
                        .frame(height: 47)
                        .focused($focused, equals: .password)
                        .submitLabel(.done)
                    RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
                        .stroke(lineWidth: 1)
                        .frame(height: 47)
                        .foregroundColor($viewModel.passwordTextFieldColor.wrappedValue)
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
                    Text("Forgot password?")
                        .fontStyle(.clearButtonsText)
                }
            }.disabled($viewModel.passwordResetIsEnabled.wrappedValue ? false : true)
            
            Button {
                viewModel.didTapOnLogin()
            } label: {
                TextView(text: "Log In", font: .poppinsSemiBold, size: 14)
            }
            .buttonStyle(StandartButtonStyle())
            .padding(.top, Spacings.spacing25)
            .isDisabled(viewModel.loginButtonDisabled)
            
            Spacer()
            
            Button {
                viewModel.didTapOnRegister()
            } label: {
                Text("Don`t have an account? Create new")
                    .fontStyle(.clearButtonsText)
            }
        }.padding(Spacings.spacing30)
            .overlay{
                if viewModel.state == .loading {
                    CustomProgressView()
                }
            }
            .alert($viewModel.error.wrappedValue, isPresented: $viewModel.isShowingAlert) {
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
