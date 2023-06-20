//
//  AuthentificationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.06.2023.
//

import SwiftUI

struct AuthentificationView: View {
    @StateObject var viewModel: AuthentificationViewModel
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                TextView(text: "Log In", font: .poppinsSemiBold, size: 36)
                Spacer()
            }
            Group {
                
                TextField("", text: $viewModel.email, prompt: Text("Email").foregroundColor(Color.black))
                    .keyboardType(.emailAddress)
//                    .overlay {
//                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
//                            .stroke(lineWidth: 1)
//                            .foregroundColor($viewModel.emailTextFieldColor.wrappedValue)
//                    }
                
                SecureField("", text: $viewModel.password, prompt: Text("Password, at least 8 characters").foregroundColor(.black))
//                    .overlay {
//                        RoundedRectangle(cornerRadius: LayoutConstants.cornerRadius)
//                            .stroke(lineWidth: 1)
//                            .foregroundColor($viewModel.passwordTextFieldColor.wrappedValue)
//                    }
            }
            .padding(.horizontal, Spacings.spacing25)
            .frame(height: 47)
            .font(.custom(FontsEnum.poppinsRegular.rawValue, size: 14))
            .background(Color(ColorConstants.gray))
            .foregroundColor(Color.black)
            .autocorrectionDisabled(true)
            .textInputAutocapitalization(.never)
            .cornerRadius(LayoutConstants.cornerRadius, corners: .allCorners)
            Button {
                print("k")
            } label: {
                HStack {
                    Spacer()
                    Text("Forgot password?")
                        .modifier(TextViewModifier(font: .poppinsMedium, size: 14))
                }
            }
            
            Button {
                viewModel.userDidTapOnLogin()
            } label: {
                TextView(text: "Log In", font: .poppinsSemiBold, size: 14)
            }
            .buttonStyle(StandartButtonStyle())
            //            .modifier(ButtonOpacityViewModifier(isDisabled: $viewModel.loginButtonDisabled.wrappedValue))
            .padding(.top, Spacings.spacing25)
            .disabled($viewModel.loginButtonDisabled.wrappedValue ? false : true)
            
            Spacer()
            
            Button {
                viewModel.userDidTapOnRegister()
            } label: {
                TextView(text: "Don`t have an account? Create new", font: .poppinsSemiBold, size: 14)
            }
        }.padding(Spacings.spacing30)
            .alert($viewModel.error.wrappedValue, isPresented: $viewModel.isShowingAlert) {
                Button("OK") {}
            }
    }
    
    private var buttonOpacity: Color {
        $viewModel.loginButtonDisabled.wrappedValue ? Color(ColorConstants.buttonsColor).opacity(0.5) : Color(ColorConstants.buttonsColor).opacity(1.0)
    }
}
//
struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        let service = AuthentificationService()
        @State var mock = AuthentificationViewModel(authentificationService: service)
        AuthentificationView(viewModel: mock)
    }
}
