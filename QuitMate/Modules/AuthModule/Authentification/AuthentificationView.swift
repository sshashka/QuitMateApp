//
//  AuthentificationView.swift
//  QuitMate
//
//  Created by Саша Василенко on 06.06.2023.
//

import SwiftUI

struct AuthentificationView: View {
    @Binding var email: String
    var body: some View {
        VStack {
            Spacer()
            HStack {
                TextView(text: "Log In", font: .poppinsSemiBold, size: 36)
                Spacer()
            }
                TextField("Email", text: $email)
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .font(.custom(FontsEnum.poppinsRegular.rawValue, size: 14))
                    .background(Color(ColorConstants.gray))
                    .cornerRadius(LayoutConstants.cornerRadius, corners: .allCorners)

                TextField("Password, at least 8 characters", text: $email)
                    .padding(.horizontal, Spacings.spacing25)
                    .frame(height: 47)
                    .font(.custom(FontsEnum.poppinsRegular.rawValue, size: 14))
                    .background(Color(ColorConstants.gray))
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
                print("Sas")
            } label: {
                TextView(text: "Log In", font: .poppinsSemiBold, size: 14)
            }.buttonStyle(StandartButtonStyle())
                .padding(.top, Spacings.spacing25)
            Spacer()
            Button {
                print("Sayas")
            } label: {
                TextView(text: "Don`t have an account? Create new", font: .poppinsSemiBold, size: 14)
            }
        }.padding(Spacings.spacing30)
    }
}

struct AuthentificationView_Previews: PreviewProvider {
    static var previews: some View {
        @State var email: String = ""
        AuthentificationView(email: $email)
    }
}
